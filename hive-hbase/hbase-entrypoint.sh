#!/bin/bash

sleep 20
/opt/hbase-$HBASE_VERSION/bin/hbase regionserver start > logregion.log 2>&1 &
#/opt/hbase-$HBASE_VERSION/bin/hbase regionserver start
echo "Started regionserver"

/opt/hbase-$HBASE_VERSION/bin/hbase master start --localRegionServers=0
#/opt/hbase-$HBASE_VERSION/bin/hbase master start
echo "Started master"

#./hbase-daemon.sh start regionserver
#./hbase-daemon.sh start master
./hbase-daemon.sh start rest
echo "Started rest"

tail -f /opt/hbase-$HBASE_VERSION/logs/*

#/usr/local/hbase/bin/hbase-daemon.sh start regionserver
#/usr/local/hbase/bin/hbase-daemon.sh start master  134217728 CMD ["java","-jar","/data/test1.jar"]