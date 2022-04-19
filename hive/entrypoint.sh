#!/bin/bash

cmd="$@"

sleep 10
hdfs dfs -mkdir /tmp
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /tmp
hdfs dfs -chmod g+w /user/hive/warehouse

echo "Configuring Hive..."
schematool -dbType postgres -initSchema -verbose
hive --service metastore &
hiveserver2 &
echo "hive started"

hive show databases;
hive create databases eee;
#exec $cmd