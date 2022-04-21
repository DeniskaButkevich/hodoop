FROM dez/base-alpine:latest

ENV KAFKA_VERSION 2.7.1
ENV SCALA_VERSION 2.13

USER root

RUN apk add --no-cache docker coreutils su-exec
RUN apk add --no-cache -t .build-deps ca-certificates \
  && mkdir -p /opt \
  && curl -fSL "https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" \
  | tar -xzf - -C /opt \
  && mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka \
  && adduser -DH -s /sbin/nologin kafka \
  && chown -R kafka: /opt/kafka \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

ENV PATH /sbin:/opt/kafka/bin/:$PATH

WORKDIR /opt/kafka

#VOLUME ["/tmp/kafka-logs"]

EXPOSE 9092 2181

# COPY config/log4j.properties /opt/kafka/config/
COPY config/server.properties /opt/kafka/config/
COPY config/zookeeper.properties /opt/kafka/config/
COPY kafka-entrypoint.sh /kafka-entrypoint.sh
COPY scripts /

RUN chmod +x /kafka-entrypoint.sh
RUN chmod +x /configure-kafka.sh
RUN chmod +x /configure-zookeeper.sh
RUN chmod +x /create-topics.sh
RUN chmod +x /wait-for-it.sh

USER root


ENTRYPOINT ["/kafka-entrypoint.sh"]
CMD ["kafka-server-start.sh", "config/server.properties"]
