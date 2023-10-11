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

ha network update wlan0 --ipv4-method auto --wifi-auth wpa-psk --wifi-mode infrastructure --wifi-ssid 'FARMURBAN' --wifi-psk 'XXX'

a40cadcb7a7e19f1

go_memstats_heap_alloc_bytes

CONFIG/network/my-network
[connection]
id=my-network
uuid=da120cca-5e30-4014-824c-7ba5dc0147aa
type=802-11-wireless

[802-11-wireless]
mode=infrastructure
ssid=FARMURBAN

[802-11-wireless-security]
auth-alg=open
key-mgmt=wpa-psk
psk=FARM123!

[ipv4]
method=auto

[ipv6]
method=auto
addr-gen-mode=default

`nmcli con show`
