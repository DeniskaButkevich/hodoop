#!/bin/bash

#if [ ! -d "/home/hduser/hadoop-3.3.1/data/dfs/datanode" ]; then
#        hdfs namenode -format
#fi

start-dfs.sh
start-yarn.sh

tail -f /dev/null
