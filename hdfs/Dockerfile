FROM alpine-base

ENV HADOOP_VERSION 3.3.1

WORKDIR /home/hduser

# download hadoop
RUN wget --limit-rate=1G https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

# configure passwordless SSH
RUN \
 ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
 ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
 ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
 cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ADD ssh_config /root/.ssh/config

RUN \
 chmod 600 /root/.ssh/config && \
 chown root:root /root/.ssh/config && \
 echo "Port 2122" >> /etc/ssh/sshd_config && \
 passwd -u root

# Change default shell
RUN \
 echo 'http://dl-cdn.alpinelinux.org/alpine/v3.14/community' >> /etc/apk/repositories && \
 apk add libuser && touch /etc/login.defs && mkdir /etc/default && touch /etc/default/useradd && echo "/bin/bash" | lchsh root

# extract Hadoop
RUN tar zxvf hadoop-${HADOOP_VERSION}.tar.gz && rm hadoop-${HADOOP_VERSION}.tar.gz

ENV \
 HDFS_NAMENODE_USER=root \
 HDFS_DATANODE_USER=root \
 HDFS_SECONDARYNAMENODE_USER=root \
 YARN_RESOURCEMANAGER_USER=root \
 YARN_NODEMANAGER_USER=root 

ENV HADOOP_HOME /home/hduser/hadoop-${HADOOP_VERSION}

RUN echo 'export JAVA_HOME=/opt/ibm/java/jre' >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh 

COPY \
 core-site.xml \
 hdfs-site.xml \
 yarn-site.xml \
 docker-entrypoint.sh \
 $HADOOP_HOME/etc/hadoop/

RUN \
 chmod +x /home/hduser/hadoop-${HADOOP_VERSION}/etc/hadoop/docker-entrypoint.sh && \
 chmod +x /home/hduser/hadoop-${HADOOP_VERSION}/etc/hadoop/hadoop-env.sh  && \
 # for normal operation of the shell script under Windows
 dos2unix /home/hduser/hadoop-${HADOOP_VERSION}/etc/hadoop/docker-entrypoint.sh

# #todo mayb add java home
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

EXPOSE 50070 50075 50010 50020 50090 8020 9000 9864 9870 10020 19888 8088 8030 8031 8032 8033 8040 8042 8888 22

ENTRYPOINT ["/home/hduser/hadoop-3.3.1/etc/hadoop/docker-entrypoint.sh"]
