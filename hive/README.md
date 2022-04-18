# Run hdfs + hive (postgres metastore)

#### include:

+ Namenode
+ Datanode
+ secondarynamenode
+ resourcemanager
+ nodemanager


+ metastore
+ hiveserveer2

___

### Get start

```dockerfile
#this should run all cluster
1. bash> docker-compose up
```

### Run hive

```dockerfile

#for working from bash (use this in another terminal)
1. bash> docker exec -it hive bash
2. bash> hive
3. hive> show databases;
```

### Connect to the postgres

```dockerfile

#for working from bash (use this in another terminal)
1. bash> docker exec -it db bash
2. bash> psql -h db -U admin -d metastore_db
    2.1 password -> "admin"
3. bash> \dt *. *; "this is show all tables"
```

---

### Helps

+ to check status use `$bash ps` because jre is not included JPS

+ UI Namenode information -> `localhost:9870`

## Version
3.1.2

## Building the image
- ``docker build -t base_alpine_hive:3.1.2 .``

## Running
- ``docker run --name hive -p 10000:10000 -p 10002:10002 -p 9083:9083 -it base_alpine_hive:3.1.2``
