FROM dez/base-alpine:latest

ENV HADOOP_VERSION 3.3.1
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN \
    curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz && \
    curl -fSL "$HADOOP_URL.asc" -o /tmp/hbase.tar.gz.asc && \
    tar -zxvf /tmp/hadoop.tar.gz -C /opt/ && \
    rm /tmp/hadoop.tar.gz*

ENV \
 HDFS_NAMENODE_USER=root \
 HDFS_DATANODE_USER=root \
 HDFS_SECONDARYNAMENODE_USER=root \
 YARN_RESOURCEMANAGER_USER=root \
 YARN_NODEMANAGER_USER=root

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs
RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $PATH:$HADOOP_HOME/bin/:$HADOOP_HOME/sbin


RUN echo 'export JAVA_HOME=/opt/ibm/java/jre' >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
RUN echo 'HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}' >> ~/.bashrc
RUN echo 'PATH=$PATH:$HADOOP_HOME/bin' >> ~/.bashrc
RUN echo 'PATH=$PATH:$HADOOP_HOME/sbin' >> ~/.bashrc


COPY \
 core-site.xml \
 hdfs-site.xml \
 yarn-site.xml \
 mapred-site.xml \
 entrypoint.sh \
 ${HADOOP_CONF_DIR}/

RUN \
 chmod +x ${HADOOP_CONF_DIR}/entrypoint.sh && \
 chmod +x ${HADOOP_CONF_DIR}/hadoop-env.sh  && \
 # for normal operation of the shell script under Windows
 dos2unix ${HADOOP_CONF_DIR}/entrypoint.sh

RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

RUN mkdir -p /src/notebooks
VOLUME /sys/fs/cgroup

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000 9870 9864
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122 8080 8888

ENTRYPOINT ["/opt/hadoop-3.3.1/etc/hadoop/entrypoint.sh"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--allow-root"]