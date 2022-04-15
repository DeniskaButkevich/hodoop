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

