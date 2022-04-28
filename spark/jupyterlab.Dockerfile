FROM dez/base-alpine-spark:2.4.5

ARG jupyterlab_version=3.3.4
ARG spark_version=3.0.0

RUN \
  apk add  --update --no-cache \
  libffi-dev \
  py3-pygments \
  py3-cffi \
  py3-cryptography \
  py3-jinja2 \
  py3-openssl \
  py3-pexpect \
  py3-tornado \
  py3-pip \
  gcc \
  musl-dev \
  && pip3 install --no-cache-dir --upgrade setuptools pip \
  && pip install wheel\
  && pip3 install wget jupyterlab==${jupyterlab_version}\
  && pip3 install --ignore-installed distlib pipenv\
  && pip3 install virtualenv \
    && apk del --purge gcc musl-dev \
      && rm -rf /var/lib/apt/lists/*  \
      && rm -rf /var/cache/apk/* \
      && rm -r /root/.cache

EXPOSE 8888
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=