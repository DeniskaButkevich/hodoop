#!/bin/bash

if [ ! -d "/home/hduser/hadoop-3.3.1/data/dfs/datanode" ]; then
        hdfs namenode -format
fi

hdfs --daemon start namenode
echo "namenode started"

hdfs --daemon start datanode
echo "datanode started"

tail -f /dev/null
