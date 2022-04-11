FROM ibmjava:8-jre-alpine

RUN \
 apk add --no-cache nano && \
 apk add --no-cache openssh && \
 apk add --no-cache bash

RUN apk add --no-cache dos2unix

RUN apk update && apk add wget

WORKDIR /home/hduser

RUN wget --limit-rate=1G https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz

# configure passwordless SSH
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

RUN echo "Port 2122" >> /etc/ssh/sshd_config

RUN passwd -u root

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.14/community' >> /etc/apk/repositories
RUN apk update
RUN apk add libuser && touch /etc/login.defs && mkdir /etc/default && touch /etc/default/useradd && echo "/bin/bash" | lchsh root

# Hadoop
RUN tar zxvf hadoop-3.3.1.tar.gz && rm hadoop-3.3.1.tar.gz

ENV HDFS_NAMENODE_USER root
ENV HDFS_DATANODE_USER root
ENV HDFS_SECONDARYNAMENODE_USER root
ENV YARN_RESOURCEMANAGER_USER root
ENV YARN_NODEMANAGER_USER root
ENV HADOOP_HOME /home/hduser/hadoop-3.3.1

RUN echo 'export JAVA_HOME=/opt/ibm/java/jre' >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh 

COPY core-site.xml $HADOOP_HOME/etc/hadoop/
COPY hdfs-site.xml $HADOOP_HOME/etc/hadoop/
COPY yarn-site.xml $HADOOP_HOME/etc/hadoop/

COPY docker-entrypoint.sh $HADOOP_HOME/etc/hadoop/

RUN chmod +x /home/hduser/hadoop-3.3.1/etc/hadoop/docker-entrypoint.sh
RUN chmod +x /home/hduser/hadoop-3.3.1/etc/hadoop/hadoop-env.sh
RUN dos2unix /home/hduser/hadoop-3.3.1/etc/hadoop/docker-entrypoint.sh

# #todo mayb add java home
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

EXPOSE 50070 50075 50010 50020 50090 8020 9000 9864 9870 10020 19888 8088 8030 8031 8032 8033 8040 8042 8888 22

ENTRYPOINT ["/home/hduser/hadoop-3.3.1/etc/hadoop/docker-entrypoint.sh"]
