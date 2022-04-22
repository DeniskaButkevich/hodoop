# Hadoop cluster
Build a lightweight (based on Alpine) hadoop cluster with below mentioned hadoop services.

## Versions
- Alpine Linux: 3.12
- Postgres: 11.4
- Java: IBM JDK 8
- hadoop: 3.3.1
- Hive: 3.1.2
- Hbase: 2.4.9
- Kafka: 2.7.1
- Zookeeper: 3.5.6

## Prerequsities
- Install [Docker](https://docs.docker.com/engine/installation/)
- Install [Docker compose](https://docs.docker.com/compose/install/)

## Building all images

You can run each component separately. All together - in dev

## Verification
- ``docker images`` to see all images created with proper tag version
- ``docker logs -f _CONTAINER_NAME_`` to follow logs for a specific container

## Starting

``docker-compose up``  (foreground process)

## Stopping

``docker-compose stop``


## Web UI
- [Hadoop cluster - port:9864](http://localhost:9864)
- [Hadoop namenode - port:9870](http://localhost:9870)


- [HBase Master Web UI - port:60010](http://localhost:60010)
- [HBase Regionserver web UI - port:60030](http://localhost:60030)
- [HBase Rest server web UI - port:8090](http://localhost:8090)


- [Hive UI - port:10002](http://localhost:10002)
- [Jupyter - port:8888](http://localhost:8888)


## READMEs
Go through below READMEs to get detailed information about each image

- [Alpine base README](alpine/README.md)
- [Hadoop README](hadoop/README.md)
- [Hive README](hive/README.md)
- [Hbase README](hbase/README.md)
- [Zookeeper README](zookeeper/README.md)
- [Kafka README](kafka/README.md)
- [Jupyter README](jupyter/README.md)
