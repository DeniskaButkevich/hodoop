FROM ibmjava:8-jre-alpine

# dependencies
RUN apk add --no-cache \
    nano \
    openssh \
    openrc \
    bash \
    dos2unix \
    curl \
    busybox-extras && \
    #For Change default shell. Alpine:3:12 not have an apk libuser component. but this component is exist in a version 3.14 and works fine with 3.12.
    echo 'http://dl-cdn.alpinelinux.org/alpine/v3.14/community' >> /etc/apk/repositories && \
    apk --no-cache add libuser && \
      rm -rf /var/lib/apt/lists/*

RUN sed -i '$d' /etc/apk/repositories