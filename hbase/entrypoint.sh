#!/bin/bash

sleep 20
/opt/hbase-$HBASE_VERSION/bin/hbase regionserver start > logregion.log 2>&1 &
echo "Started regionserver"

/opt/hbase-$HBASE_VERSION/bin/hbase master start --localRegionServers=0
echo "Started master"

./hbase-daemon.sh start rest
echo "Started rest"

tail -f /opt/hbase-$HBASE_VERSION/logs/*