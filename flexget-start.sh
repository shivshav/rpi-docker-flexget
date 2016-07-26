#!/bin/bash

set -e

FIRST_RUN=first-run.sh
if [[ -x /$FIRST_RUN ]]; then
    /$FIRST_RUN
fi

echo "Start up flexget."

exec su -s /bin/bash -c "/usr/local/bin/flexget -c /data/config/config.yml daemon start"
