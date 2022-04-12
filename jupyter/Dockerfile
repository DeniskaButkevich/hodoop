FROM ubuntu:20.04

ENV HDFS_USER hdfs_user

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install sudo -y && \
    apt-get install nano -y && \
    apt-get install dos2unix -y && \
    sudo apt-get install openssh-server openssh-client -y

#add hdfs user to hadoop group with root privilages
RUN sudo addgroup hadoop
RUN sudo echo -e  "adduser --ingroup hadoop $HDFS_USER <<EOF\n$PASS\n$PASS\nEOF"  >  addnewuser.sh
RUN chmod +x addnewuser.sh
RUN ./addnewuser.sh
RUN usermod -aG sudo $HDFS_USER
RUN echo "$HDFS_USER ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

#allow running ssh without password asking
RUN sudo echo -e "Host *\nStrictHostKeyChecking no\nUserKnownHostsFile=/dev/null" >>  /etc/ssh/ssh_config
#disable ipv6
RUN sudo echo -e 'net.ipv6.conf.all.disable_ipv6=1\nnet.ipv6.conf.default_ipv6=1\nnet.ipv6.conf.lo.disable_ipv6=1' >> /etc/sysctl.conf

RUN apt-get install -y build-essential python3.6 python3-pip python3-dev
RUN pip3 -q install pip --upgrade
RUN echo 'export PATH=$PATH:/home/${HDFS_USER}/./local/bin' >> ~/.bashrc
RUN . ~/.bashrc

RUN mkdir src
WORKDIR src/

RUN pip3 install jupyter && pip3 install virtualenv

WORKDIR /src/notebooks

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]

USER  $HDFS_USER

#expose Jupyter notebook default port
EXPOSE 8888


