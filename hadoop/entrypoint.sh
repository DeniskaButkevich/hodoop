#!/bin/bash

cmd="$@"
#sleep 5
if [ "`ls -A "/hadoop/dfs/name"`" == "" ]; then
  #incompitable cluster ids https://www.its404.com/article/taotoxht/42713103 temp workaround
  rm -Rf /tmp/hadoop-root/*
  echo "Formatting namenode name directory: /hadoop/dfs/name"
  hdfs --config $HADOOP_CONF_DIR namenode -format
fi
#
#if [ "`ls -A "/hadoop/dfs/test/name"`" == "" ]; then
#  echo "Formatting namenode name directory: /hadoop/dfs/name"
#  hdfs --config $HADOOP_CONF_DIR namenode -format
#fi


echo "Starting Hadoop name node..."
hdfs --daemon start --config $HADOOP_CONF_DIR namenode
hdfs --daemon start --config $HADOOP_CONF_DIR secondarynamenode
yarn --daemon start --config $HADOOP_CONF_DIR resourcemanager
yarn --daemon start --config $HADOOP_CONF_DIR nodemanager
mapred --daemon start --config $HADOOP_CONF_DIR historyserver
sleep 2
echo "Starting Hadoop data node..."
hdfs --daemon start --config $HADOOP_CONF_DIR datanode
 hdfs dfsadmin -safemode leave
echo "!!!CLUSTER STARTED!!!"

exec $cmd
