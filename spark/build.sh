docker build -t dez/base-alpine:latest ../alpine

docker build -t dez/base-alpine-hadoop:3.3.1 ../hadoop

docker build -t dez/base-alpine-spark:2.4.5 .

docker build -f jupyterlab.Dockerfile -t dez/base-alpine-jupyterlab:latest .