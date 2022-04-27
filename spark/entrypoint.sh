#!/bin/bash

sleep 5
echo "Starting spark"

SPARK_LOGS_HDFS_PATH=/log/spark
if ! hadoop fs -test -d "${SPARK_LOGS_HDFS_PATH}"
then
   hadoop fs -mkdir -p  ${SPARK_LOGS_HDFS_PATH}
   hadoop fs -chmod -R 755 ${SPARK_LOGS_HDFS_PATH}/*
fi

SPARK_JARS_HDFS_PATH=/spark-jars
if ! hadoop fs -test -d "${SPARK_JARS_HDFS_PATH}"
then
  hadoop dfs -copyFromLocal "${SPARK_HOME}/jars" "${SPARK_JARS_HDFS_PATH}"
fi


"${SPARK_HOME}/sbin/start-master.sh" -h spark &
"${SPARK_HOME}/sbin/start-history-server.sh" &
echo "Starting Spark slave node..."

"${SPARK_HOME}/sbin/start-slave.sh" spark:7077 &

tail -f /dev/null
