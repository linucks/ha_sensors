# ha_sensors

Repository for Home Assistant Sensors

## Required Addons

- https://github.com/hassio-addons/addon-ssh
- https://github.com/hassio-addons/addon-mqtt-io
- https://github.com/home-assistant/addons/tree/master/mosquitto
- https://github.com/hassio-addons/addon-motioneye
- https://github.com/hassio-addons/addon-tailscale

### Useful Addons

- https://github.com/hassio-addons/addon-vscode

## Networking

To configure the connection for a wifi not present at setup:

- https://github.com/home-assistant/operating-system/blob/dev/Documentation/network.md

## MQTT

### Security

- https://tasmota.github.io/docs/Securing-your-IoT-from-hacking/
- https://www.hivemq.com/blog/mqtt-security-fundamentals-securing-mqtt-systems/
- https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-the-mosquitto-mqtt-messaging-broker-on-ubuntu-16-04

## Equipment

- https://www.mylocalbytes.com/products/smart-plug-pm?variant=41600621510847

## Commands

docker exec -it $(docker container ls | grep rpi-ardcli | cut -f1 -d " ") /bin/sh
