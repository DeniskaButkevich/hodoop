#!/bin/bash

/usr/sbin/sshd

ssh start

jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root

