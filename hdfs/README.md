# start docker container
___

## with dockerfile
```dockerfile
#build image
1. docker build -t <name image> .

#this should run **namenode** and **datanode**
2. docker run --name <container name> -p 9864:9864 -p 9870:9870 -p 8088:8088  --hostname <hostname>  <image name>

#for work from bash
3. docker exec -it <container name> bash
```
to check status use `hdfs dfsadmin -report` because jre is not included JPS
## with docker-compose

```dockerfile
#this should run **namenode** and **datanode**
1. docker-compose up

#for working from bash (use this in another terminal)
2. docker exec -it hadoop bash
```
to check status use `hdfs dfsadmin -report` because jre is not included JPS
