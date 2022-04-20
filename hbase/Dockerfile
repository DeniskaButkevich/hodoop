FROM dez/base-alpine:latest

ENV HBASE_VERSION 2.4.9

# Download and Install HBase
RUN curl -O http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz && \
   tar xzf hbase-$HBASE_VERSION-bin.tar.gz -C /opt/ && \
   ln -s /opt/hbase-$HBASE_VERSION /opt/hbase && \
   rm hbase-$HBASE_VERSION-bin.tar.gz

ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml

RUN mkdir /opt/hbase/data
RUN mkdir /opt/hbase/logs

RUN mkdir /hadoop-data
ENV USER=root

ENV PATH=$PATH:/opt/hbase/bin

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030
# HBase Rest server
EXPOSE 8070
# HBase Rest server web UI
EXPOSE 8090

WORKDIR /opt/hbase/bin

ENTRYPOINT ["/entrypoint.sh"]