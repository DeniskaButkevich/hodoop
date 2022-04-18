FROM base_alpine

ENV HDFS_USER root

RUN mkdir src
WORKDIR src/

# dependencies for jupyter
RUN \
  apk add \
  libffi-dev \
  py3-pygments \
  py3-cffi \
  py3-cryptography \
  py3-jinja2 \
  py3-openssl \
  py3-pexpect \
  py3-tornado \
  python3 \
  python3-dev && \
  apk add cmd:pip3 && \
  pip3 install --no-cache-dir --upgrade setuptools pip
# install jupyter  
RUN apk --no-cache add gcc musl-dev

RUN pip install wheel
RUN pip3 install jupyter
RUN pip3 install --ignore-installed distlib pipenv
RUN pip3 install virtualenv 
RUN apk del --purge gcc musl-dev && \
  rm -r /root/.cache && rm -rf /var/cache/apk/* 

WORKDIR /src/notebooks

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]

USER  $HDFS_USER

#expose Jupyter notebook default port
EXPOSE 8888
