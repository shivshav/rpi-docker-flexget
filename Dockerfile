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
RUN pip install -U pip && /usr/local/bin/pip install -U setuptools urllib3[secure]

RUN pip install flexget transmissionrpc

RUN mkdir -p /data/sorted/movies /data/config /data/completed_downloads/movies

COPY first-run.sh flexget-start.sh config.yml.template /

VOLUME /data/sorted/movies /data/config /data/completed_downloads/movies

# FGUSER
# CONFIG
# LOG
# LEVEL

ENTRYPOINT ["/flexget-start.sh"]
