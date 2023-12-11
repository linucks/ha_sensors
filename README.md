# ha_sensors

This repository provides a Home Assistant plugin to allow a DFRobot HAT to be flashed from a Raspberry Pi running Home Assistant

## Installation of the Base Home Assistant OS and DFRobot sensors
* Flash an SD card with a full installation of Home Assistant and boot the Raspberry PI.
* Install Tailscale and community SSH addons to facilitate ssh access to the pi.
* Install the MQTT Eclipse addon and run on ports 1833/4 8883/4
* Install the [MQTT IO](https://github.com/hassio-addons/addon-mqtt-io) addon to read the sensor data coming from /dev/ttyACM0 on the pi.
* copy/update the files from the config directory of this repository to the config directory on the pi.

## Getting this Addon to work
* Build and upload the docker image using the build.sh script.
* ?? copy the config.yml file to the pi in the folder /root/addons/ha_sensors
* Go to the hassio/addon page and install the addon
* Go to the page `hassio/addon/local_rpi-ardcli/info` and start the addon
* ssh into the rpi and enter the container: `docker exec -it $(docker ps | grep ardcli | awk '{print $NF}') /bin/bash`
* cd into the arduino code directory: `cd /rpi_arduino_shield/rpi_arduino_shield`
* edit `rpi_arduino_shield.ino` and upload to the hat with: `../upload.sh`
* stop the addon.


## Tapo Webcam
Clone repository from https://github.com/JurajNyiri/HomeAssistant-Tapo-Control
scp custom_components/tapo_control to the config folder on the pi. NB by default scp copies into the user account so I found it easiest to tgz the file and then unpack at the other end.
* add the webcam to the network using the Tapo app.
* create a camera account on the camera with the Tapo app (Camera -> Device Settings -> Advanced Settings -> Camera Account)


## USB Webcam
* use [Motion Eye plugin](https://github.com/hassio-addons/addon-motioneye) to control the USB webcam.


## Required Addons

- https://github.com/hassio-addons/addon-ssh
- https://github.com/hassio-addons/addon-mqtt-io
- https://github.com/home-assistant/addons/tree/master/mosquitto
- https://github.com/hassio-addons/addon-motioneye
- https://github.com/hassio-addons/addon-tailscale

### Useful Addons
For editing the YAML files (although it was very buggy)
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
