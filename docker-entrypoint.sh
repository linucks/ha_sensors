#!/usr/bin/env bashio

CONFIG_FILE=/sensors/rpi/config.yml

MQTT_HOST=$(bashio::services mqtt "host")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASSWORD=$(bashio::services mqtt "password")

sed -e "s/MQTT_USER/$MQTT_USER/" -e "s/MQTT_PASSWORD/$MQTT_PASSWORD/" -e "s/MQTT_HOST/$MQTT_HOST/" < ${CONFIG_FILE}.tpl > $CONFIG_FILE

exec "$@" 
