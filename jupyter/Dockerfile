FROM dez/base-alpine:latest

USER root

RUN mkdir src
WORKDIR src/

# dependencies for jupyter
RUN \
  apk add  --update --no-cache \
  nano \
  bash \
  openssh \
  libffi-dev \
  py3-pygments \
  py3-cffi \
  py3-cryptography \
  py3-jinja2 \
  py3-openssl \
  py3-pexpect \
  py3-tornado \
  python3 \
  python3-dev \
  py3-pip \
  gcc \
  musl-dev \
  && pip3 install --no-cache-dir --upgrade setuptools pip \
  && pip install wheel\
  && pip3 install jupyter\
  && pip3 install --ignore-installed distlib pipenv\
  && pip3 install virtualenv \
    && apk del --purge gcc musl-dev \
      && rm -rf /var/lib/apt/lists/*  \
      && rm -rf /var/cache/apk/* \
      && rm -r /root/.cache

WORKDIR /src/notebooks

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]

#expose Jupyter notebook default port
EXPOSE 8888