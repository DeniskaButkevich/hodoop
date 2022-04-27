#!/bin/bash

cmd="$@"

if [ "`ls -A "/hadoop/dfs/name"`" == "" ]; then
  echo "Formatting namenode name directory: /hadoop/dfs/name"
  hdfs --config $HADOOP_CONF_DIR namenode -format
fi

echo "Starting Hadoop name node..."
hdfs --daemon start --config $HADOOP_CONF_DIR namenode
hdfs --daemon start --config $HADOOP_CONF_DIR secondarynamenode
yarn --daemon start --config $HADOOP_CONF_DIR resourcemanager
mapred --daemon start --config $HADOOP_CONF_DIR historyserver
sleep 2

echo "Starting Hadoop data node..."
hdfs --daemon start --config $HADOOP_CONF_DIR datanode
#hdfs --daemon start --config $HADOOP_CONF_DIR nodemanager
echo "!!!CLUSTER STARTED!!!"

exec $cmd
