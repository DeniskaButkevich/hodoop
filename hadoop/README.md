# Run base hdfs

#### include:

+ Namenode
+ Datanode

___

## with dockerfile

```dockerfile
#build image
1. bash> docker build -t <name image> .

#this should run **namenode** and **datanode**
2. bash> docker run --name <container name> -p 9864:9864 -p 9870:9870 -p 8088:8088  --hostname <hostname>  <image name>

#for work from bash
3. bash> docker exec -it <container name> bash
```

## with docker-compose

```dockerfile
#this should run **namenode** and **datanode**
1. bash>  docker-compose up

#for working from bash (use this in another terminal)
2. bash> docker exec -it hadoop bash
```

---

### Helps

+ to check status use `$bash ps` because jre is not included JPS

+ UI Namenode information -> `localhost:9870`

## Version
3.3.1


## Building the image
- ``docker build -t base_alpine_hadoop:3.3.1 .``

## Running
- ``docker run --name hadoop -p 49707:49707 -p 50010:50010 -p 50020:50020 -p 50030:50030 -p 50070:50070 -p 50075:50075 -p 50090:50090 -p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8040:8040 -p 8042:8042 -p 8088:8088 -p 9870 -it dez/hadoop_alpine:3.3.1``

## UI
- http://localhost:8088/
- http://localhost:9870/