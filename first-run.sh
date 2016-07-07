#!/bin/bash

CONFIG=/data/flexget/config.yml

TRAKT_LIST=${TRAKT_LIST:-watchlist}

if [[ -z "$TR_USERNAME" || -z "$TR_PASSWORD" || -z "$TRAKT_ACCOUNT" ]]; then
    echo "No values given for transmission and trakt access. Recommend recreating container with '\$TR_USERNAME', '\$TR_PASSWORD', and '\$TRAKT_ACCOUNT'  environment variables set."
    exit 1
fi

sed -i "s/{{TR_USERNAME}}/${TR_USERNAME}/g" ${CONFIG}
sed -i "s/{{TR_PASSWORD}}/${TR_PASSWORD}/g" ${CONFIG}
sed -i "s/{{TRAKT_ACCOUNT}}/${TRAKT_ACCOUNT}/g" ${CONFIG}
sed -i "s/{{TRAKT_LIST}}/${TRAKT_LIST}/g" ${CONFIG}

echo "Initial setup finished"
rm /first-run.sh
