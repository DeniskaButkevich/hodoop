# Run Hadoop + Spark + JupyterLab

#### include:

+ Namenode
+ Datanode
+ secondarynamenode
+ resourcemanager
+ historyserver


+ master node
+ Worker node

___

### Get start

```dockerfile
#this should run all cluster
1. bash> docker-compose up
```
### UI
Once finished, check out the components web UI:

+ JupyterLab at [`localhost:8888`](localhost:8888);
+ Spark master at [`localhost:8080`](localhost:8080);
+ Spark worker I at [`localhost:8081`](localhost:8081);
+ history.ui.port [`localhost:18080`](localhost:18080);
+ UI Namenode information  [`localhost:9870`](localhost:9870);

### Run Spark job

```dockerfile
Use JupyterLab for it
```
---

### Helps

+ to check status use `$bash ps` because jre is not included JPS

## Version
+ Spark 2.4.5  
+ Skala 2.12  
+ jupyterlab 2.1.5  