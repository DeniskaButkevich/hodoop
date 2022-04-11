#!/bin/bash
hdfs namenode -format

hdfs --daemon start namenode
hdfs --daemon start datanode

tail -f /dev/null