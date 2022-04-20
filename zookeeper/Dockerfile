FROM dez/base-alpine:latest

ENV ZOOKEEPER_VERSION 3.4.14

RUN apk add tar
#Download Zookeeper
WORKDIR /opt

RUN curl -O "http://archive.apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz"
RUN tar zxvf zookeeper-${ZOOKEEPER_VERSION}.tar.gz && rm zookeeper-${ZOOKEEPER_VERSION}.tar.gz \
    && mv /opt/zookeeper-${ZOOKEEPER_VERSION} /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg

ENV ZK_HOME /opt/zookeeper
RUN sed  -i "s|/tmp/zookeeper|$ZK_HOME/data|g" $ZK_HOME/conf/zoo.cfg; mkdir $ZK_HOME/data

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper
VOLUME ["/opt/zookeeper/conf", "/opt/zookeeper/data"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
