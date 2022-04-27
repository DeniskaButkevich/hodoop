FROM ibmjava:8-jre-alpine

# dependencies
# bash: Hadoop is not compatible with Alpine's `ash` shell
# curl and unzip: download and extract Hive, Hadoop, Spark etc.
# coreutils: Spark launcher script relies on GNU implementation of `nice`
# findutils: Spark needs GNU `find` to run jobs (weird but true)
# ncurses: so that you can run `yarn top`
# dos2unix: Text file format converters (for )
# busybox-extras: Size optimized toolbox of many common UNIX utilities
RUN apk add --no-cache \
    nano \
    openssh \
    bash \
    dos2unix \
    curl \
    unzip \
    coreutils \
    findutils \
    ncurses \
    busybox-extras && \
    #For Change default shell. Alpine:3:12 not have an apk libuser component. but this component is exist in a version 3.14 and works fine with 3.12.
    echo 'http://dl-cdn.alpinelinux.org/alpine/v3.14/community' >> /etc/apk/repositories && \
    apk --no-cache add libuser && \
      rm -rf /var/lib/apt/lists/*

RUN sed -i '$d' /etc/apk/repositories

# configure passwordless SSH
RUN \
 ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
 ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
 ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
 cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ADD ssh_config /root/.ssh/config

RUN \
 chmod 600 /root/.ssh/config && \
 chown root:root /root/.ssh/config && \
 echo "Port 2122" >> /etc/ssh/sshd_config && \
 passwd -u root


# Change default shell
RUN touch /etc/login.defs && mkdir /etc/default && touch /etc/default/useradd && echo "/bin/bash" | lchsh root