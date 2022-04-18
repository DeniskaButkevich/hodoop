# Simple jupyter with alpine

---

### Get start

```dockerfile
#this should run all cluster
1. bash> docker-compose up
```

## Version
latest

## Building the image
- ``docker build -t base_alpine_jupyter:latest .``

## Running
- ``docker run --name jupyter -p 8888:8888 -it base_alpine_jupyter:latest``
