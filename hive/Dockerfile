FROM dez/base-alpine-hadoop:3.3.1

# dependencies
RUN apk add --no-cache curl unzip lsof

ENV HIVE_VERSION=3.1.2
ENV HIVE_HOME=/usr/hive
ENV HIVE_CONF_DIR="${HIVE_HOME}/conf"
ENV PATH "${PATH}:${HIVE_HOME}/bin"
RUN curl --progress-bar -L \
  "https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz" \
    | gunzip \
    | tar -x -C /usr/ \
  && mv "/usr/apache-hive-${HIVE_VERSION}-bin" "${HIVE_HOME}" \
  && chown -R root:root "${HIVE_HOME}" \
  && mkdir -p "${HIVE_HOME}/hcatalog/var/log" \
  && mkdir -p "${HIVE_HOME}/var/log" \
  && mkdir -p "${HIVE_CONF_DIR}" \
  && chmod 777 "${HIVE_HOME}/hcatalog/var/log" \
  && chmod 777 "${HIVE_HOME}/var/log"

RUN echo 'export HIVE_HOME=/usr/hive' >> ~/.bashrc
RUN echo 'export PATH=$PATH:$HIVE_HOME/bin' >> ~/.bashrc

# Hive setup
ENV PATH="${PATH}:${HIVE_HOME}/bin"

#ENV HADOOP_VERSION 3.3.1
#ENV HADOOP_HOME /home/hduser/hadoop-${HADOOP_VERSION}
#ENV HADOOP_CLASSPATH="${HADOOP_HOME}/share/hadoop/tools/lib/*"
#ENV HADOOP_CLASSPATH="${HADOOP_CLASSPATH}:${HIVE_HOME}/lib/*"
COPY hive-site.xml "${HIVE_CONF_DIR}/"

ARG POSTGRESQL_JDBC_VERSION=42.2.24
RUN mkdir -p /usr/share/java
RUN curl -fSL https://jdbc.postgresql.org/download/postgresql-$POSTGRESQL_JDBC_VERSION.jar -o $HIVE_HOME/lib/postgresql-jdbc.jar


RUN rm -rf "${HIVE_HOME}/examples"

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 10000 9999 9083

ENTRYPOINT ["/entrypoint.sh"]
CMD ["tail -f /dev/null"]