#!/bin/bash

CONFIG_DIR=/data/flexget
CONFIG=config.yml
OVERWRITE_CONFIG=${OVERWRITE_CONFIG:-false}

TRAKT_LIST=${TRAKT_LIST:-watchlist}
SKIP_TRAKT_AUTH=${SKIP_TRAKT_AUTH:-true}

if [[ -z "$TR_USERNAME" || -z "$TR_PASSWORD" || -z "$TRAKT_ACCOUNT" ]]; then
    echo "No values given for transmission and trakt access. Recommend recreating container with '\$TR_USERNAME', '\$TR_PASSWORD', and '\$TRAKT_ACCOUNT'  environment variables set."
    exit 1
fi

# Check for the presence of a configuration file
if [[ ! -f $CONFIG_DIR/$CONFIG || "$OVERWRITE_CONFIG" = true ]]; then
    cp /${CONFIG}.template $CONFIG_DIR/$CONFIG
    sed -i "s/{{TR_USERNAME}}/${TR_USERNAME}/g" ${CONFIG_DIR}/${CONFIG}
    sed -i "s/{{TR_PASSWORD}}/${TR_PASSWORD}/g" ${CONFIG_DIR}/${CONFIG}
    sed -i "s/{{TRAKT_ACCOUNT}}/${TRAKT_ACCOUNT}/g" ${CONFIG_DIR}/${CONFIG}
    sed -i "s/{{TRAKT_LIST}}/${TRAKT_LIST}/g" ${CONFIG_DIR}/${CONFIG}
else
    echo "Configuration file will not be overwritten on volume"
fi

# Requesting trakt authorization
if [[ ! -z "$TRAKT_ACCOUNT" && $SKIP_TRAKT_AUTH = false ]]; then
    echo "Initiating trakt authorization. This command will not proceed until auth is granted by trakt to flexget."
    /usr/local/bin/flexget -c /data/flexget/config.yml trakt auth ${TRAKT_ACCOUNT}
fi
echo "Initial setup finished"
rm /first-run.sh
