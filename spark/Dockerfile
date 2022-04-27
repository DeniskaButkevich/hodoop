FROM dez/base-alpine-hadoop:3.3.1

# Spark
ENV SPARK_VERSION=3.0.0
ENV SPARK_PACKAGE "spark-${SPARK_VERSION}-bin-without-hadoop"
ENV SPARK_HOME /usr/spark
RUN curl --progress-bar -L --retry 3 \
  "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv "/usr/${SPARK_PACKAGE}" "${SPARK_HOME}"

# For inscrutable reasons, Spark distribution doesn't include spark-hive.jar
# Livy attempts to load it though, and will throw
# java.lang.ClassNotFoundException: org.apache.spark.sql.hive.HiveContext
ARG SCALA_VERSION=2.11
RUN curl --progress-bar -L \
    "https://repo1.maven.org/maven2/org/apache/spark/spark-hive_${SCALA_VERSION}/${SPARK_VERSION}/spark-hive_${SCALA_VERSION}-${SPARK_VERSION}.jar" \
    --output "${SPARK_HOME}/jars/spark-hive_${SCALA_VERSION}-${SPARK_VERSION}.jar"

# PySpark - comment out if you don't want it in order to save image space
RUN apk add --no-cache python3 python3-dev \
 && ln -s /usr/bin/python3 /usr/bin/python

# SparkR - comment out if you don't want it in order to save image space
RUN apk add --no-cache \
    'R=~3.6' \
    'R-dev=~3.6' \
    'libc-dev=~0.7' \
 && R -e 'install.packages("knitr", repos = "http://cran.us.r-project.org")'

# http://blog.stuart.axelbrooke.com/python-3-on-spark-return-of-the-pythonhashseed
ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# Spark setup
ENV PATH="${PATH}:${SPARK_HOME}/bin"
ENV SPARK_CONF_DIR="${SPARK_HOME}/conf"
ENV SPARK_LOG_DIR="${SPARK_HOME}/logs"
ENV SPARK_DIST_CLASSPATH="${HADOOP_CONF_DIR}:${HADOOP_HOME}/share/hadoop/tools/lib/*:${HADOOP_HOME}/share/hadoop/common/lib/*:${HADOOP_HOME}/share/hadoop/common/*:${HADOOP_HOME}/share/hadoop/hdfs:${HADOOP_HOME}/share/hadoop/hdfs/lib/*:${HADOOP_HOME}/share/hadoop/hdfs/*:${HADOOP_HOME}/share/hadoop/mapreduce/lib/*:${HADOOP_HOME}/share/hadoop/mapreduce/*:${HADOOP_HOME}/share/hadoop/yarn:${HADOOP_HOME}/share/hadoop/yarn/lib/*:${HADOOP_HOME}/share/hadoop/yarn/*"
COPY core-site.xml "${SPARK_CONF_DIR}"/
COPY hdfs-site.xml "${SPARK_CONF_DIR}"/
COPY spark-defaults.conf "${SPARK_CONF_DIR}"/

ENV SPARK_MASTER_HOST spark
ENV SPARK_MASTER_PORT 7077
#ENV PYSPARK_PYTHON python3

# Spark with Hive
# TODO enable in Spark 3.0
#ENV SPARK_DIST_CLASSPATH=$SPARK_DIST_CLASSPATH:$HIVE_HOME/lib/*
#COPY conf/hive/hive-site.xml $SPARK_CONF_DIR/
#RUN ln -s $SPARK_HOME/jars/scala-library-*.jar $HIVE_HOME/lib \
#    && ln -s $SPARK_HOME/jars/spark-core_*.jar $HIVE_HOME/lib \
#    && ln -s $SPARK_HOME/jars/spark-network-common_*.jar $HIVE_HOME/lib

# Clean up
RUN rm -rf "${SPARK_HOME}/examples/src"

# If both YARN Web UI and Spark UI is up, then returns 0, 1 otherwise.
#HEALTHCHECK CMD curl -f http://host.docker.internal:8080/ || exit 1

WORKDIR ${SPARK_HOME}
COPY task/ .

# Entry point: start all services and applications.
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh


# spark_worker_web_ui
EXPOSE 8081 18080 4040

#spark_master_web_ui
EXPOSE 8080

#spark_master_port
EXPOSE 7077

#ENTRYPOINT ["/entrypoint.sh"]