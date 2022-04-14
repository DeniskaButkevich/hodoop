#!/bin/bash

if [ ! -d "/home/hduser/hadoop-3.3.1/data/dfs/datanode" ]; then
        hdfs namenode -format
fi

hdfs --daemon start namenode
echo "namenode started"

hdfs --daemon start datanode
echo "datanode started"

hdfs dfs -mkdir /tmp
hdfs dfs -chmod g+w /tmp
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /user/hive/warehouse

echo "postgres -initSchema"
schematool -dbType postgres -initSchema -verbose
echo "Start metastore service"
hive --service metastore &
echo "JDBC Server"
hiveserver2 &


echo "hive started"
tail -f /dev/null
