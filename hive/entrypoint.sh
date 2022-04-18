#!/bin/bash

cmd="$@"

#if [ ! -d "/home/hduser/hadoop-3.3.1/data/dfs/datanode" ]; then
#    hdfs namenode -format
#fi
#
#  echo "Starting Hadoop name node..."
#  hdfs --daemon start namenode
#  hdfs --daemon start secondarynamenode
#  yarn --daemon start resourcemanager
#  echo "Starting Hadoop data node..."
#  hdfs --daemon start datanode
#  yarn --daemon start nodemanager

hdfs dfs -mkdir /tmp
hdfs dfs -chmod g+w /tmp
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /user/hive/warehouse

# ---------------------------
# checking if postgres has risen
host="postgres"
port="5432"

echo "!! Check postgres for available !!"

#until ping -n 1 db:5432; do
#  echo "postgres is unavailable - sleeping"
#  sleep 1
#done

echo "postgres is up - executing command"
# ---------------------------

echo "Configuring Hive..."
schematool -dbType postgres -initSchema -verbose
hive --service metastore &
hiveserver2 &
echo "hive started"

exec $cmd