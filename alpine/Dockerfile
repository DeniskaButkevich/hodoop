FROM ibmjava:8-jre-alpine

# dependencies
RUN \
 apk add --no-cache nano && \
 apk add --no-cache openssh && \
 apk add --no-cache bash && \
 apk add --no-cache dos2unix && \
 apk add --no-cache curl && \
 apk add --no-cache busybox-extras && \
 echo 'http://dl-cdn.alpinelinux.org/alpine/v3.14/community' >> /etc/apk/repositories && \
 apk --no-cache add libuser && \
    rm -rf /var/lib/apt/lists/*