FROM hdfs-base

# dependencies
RUN apk add --no-cache nano && apk add --no-cache bash
RUN apk add --no-cache curl unzip 

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

# Hive setup
ENV PATH="${PATH}:${HIVE_HOME}/bin"
ENV HADOOP_CLASSPATH="${HADOOP_CLASSPATH}:${HIVE_HOME}/lib/*"
COPY hive-site.xml "${HIVE_CONF_DIR}/"

# Clean up
RUN rm -rf "${HIVE_HOME}/examples" 

# # If both YARN Web UI and Spark UI is up, then returns 0, 1 otherwise.
# HEALTHCHECK CMD curl -f http://host.docker.internal:8080/ \
#     && curl -f http://host.docker.internal:8088/ || exit 1

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]