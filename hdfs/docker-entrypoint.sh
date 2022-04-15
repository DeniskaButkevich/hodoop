#!/bin/bash

cmd="$@"

if [ ! -d "/home/hduser/hadoop-3.3.1/data/dfs/datanode" ]; then
    hdfs namenode -format
fi

  echo "Starting Hadoop name node..."
  hdfs --daemon start namenode
  hdfs --daemon start secondarynamenode
  yarn --daemon start resourcemanager
  echo "Starting Hadoop data node..."
  hdfs --daemon start datanode
  yarn --daemon start nodemanager

exec $cmd
