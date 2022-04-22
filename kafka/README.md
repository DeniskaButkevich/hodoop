# Kafka docker image
Build a kafka docker image on Alpine Linux distro.

## Version
- Kafka: 2.7.1
- Scala 2.13

## Building the image

``docker build -t dez/base-alpine-kafka:2.7.1 .``

Just assemble the image


## Usage
Start a cluster with zookeeper and kafka:

- ``docker-compose up ``

Destroy a cluster:

- ``docker-compose stop``

## Test
You can test kafka with spring `_spring-kafka-test_` folder


## Notes
The default _docker-compose.yml_ should be seen as a starting point. By default each broker will get a new port number and broker id on restart. Depending on your use case this might not be desirable. If you need to use specific ports and broker ids, modify the docker-compose configuration accordingly

- Find the IP address of the host and put that in kafka.yml against _KAFKA_ADVERTISED_HOST_NAME_


### Automatically create topics
If you want to have kafka-docker automatically create topics in Kafka during creation, a _KAFKA_CREATE_TOPICS_ environment variable can be
added in _docker-compose.yml_.

Here is an example snippet from _docker-compose.yml_:

        environment:
          KAFKA_CREATE_TOPICS: "INBOUND:1:2,OUTBOUND:1:1"
          KAFKA_AUTO_CREATE_TOPICS_ENABLE: 'true'

_INBOUND_ topic will have 1 partition and 2 replicas, _OUTBOUND_ topic will have 1 partition and 1 replica.

## Custom environments variables
1. Refer environment variables in [Kafka documentation](http://kafka.apache.org/documentation.html#configuration)
2. Convert the variable to uppercase, replace '.' with '_'
3. Prepend KAFKA_ to the variable
4. Use the variable as an environment variable

- Advertised hostname: _KAFKA_ADVERTISED_HOST_NAME_
- Advertised port: _KAFKA_ADVERTISED_PORT_


## Kafka manager UI
Will be soon...
