FROM hypriot/rpi-python
MAINTAINER Shivneil Prasad <sprasad0603@gmail.com>

#    build-essential \
#    libssl-dev \
RUN apt-get update && apt-get install -y \
    libffi-dev \
    gcc \
    python-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# After upgrading pip, pip PATH gets misconfigured so we must provide full path to insitigate another install
# For some dependency reason, they must be upgraded separately
RUN pip install -U pip && /usr/local/bin/pip install -U setuptools

RUN pip install flexget urllib3[secure]

RUN mkdir -p /data/flexget

COPY config.yml /data/flexget/

COPY first-run.sh flexget-start.sh /

VOLUME /data/flexget
# FGUSER
# CONFIG
# LOG
# LEVEL

ENTRYPOINT ["/flexget-start.sh"]
