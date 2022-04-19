#!/bin/bash

cmd="$@"

if [ "`ls -A "/hadoop/dfs/name"`" == "" ]; then
  echo "Formatting namenode name directory: /hadoop/dfs/name"
  hdfs --config $HADOOP_CONF_DIR namenode -format
fi

hdfs --daemon start --config $HADOOP_CONF_DIR namenode
sleep 5
hdfs --daemon start --config $HADOOP_CONF_DIR datanode
echo "!!!STARTED!!!"
exec $cmd
