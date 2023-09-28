#!/usr/bin/env bashio

CONFIG_FILE=/sensors/rpi/config.yml

MQTT_HOST=$(bashio::services mqtt "host")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASSWORD=$(bashio::services mqtt "password")

envsubst '${MQTT_HOST},${MQTT_USER},${MQTT_PASSWORD}' < ${CONFIG_FILE}.tpl > $CONFIG_FILE

exec "$@"% 