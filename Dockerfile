FROM hypriot/rpi-python
MAINTAINER Shivneil Prasad <sprasad0603@gmail.com>

RUN pip install setuptools 
RUN pip install -U pip 
RUN pip install flexget

RUN mkdir -p /data/flexget

VOLUME /data/flexget
# FGUSER
# CONFIG
# LOG
# LEVEL

ENTRYPOINT ["/usr/local/bin/flexget", "--", "-c", "/data/flexget/config.yml", "daemon", "start"]
