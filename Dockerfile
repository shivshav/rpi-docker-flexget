FROM hypriot/rpi-python
MAINTAINER Shivneil Prasad <sprasad0603@gmail.com>

# Pip and setuptools must be upgraded separately for some reason
RUN pip install -U pip 
RUN pip install -U setuptools
RUN pip install flexget

RUN mkdir -p /data/flexget

COPY config.yml /data/flexget/

COPY first-run.sh flexget-start.sh /

VOLUME /data/flexget
# FGUSER
# CONFIG
# LOG
# LEVEL

ENTRYPOINT ["/flexget-start.sh"]
