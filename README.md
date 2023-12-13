# ha_sensors
This repository is used to provision a Raspberry Pi with a Home Assistant installation for monitoring and controlling Farm Urban Edible Walls.

The Raspberry Pi requires an Arduino Shield for attaching the sensors:
* [Gravity: Arduino Shield for Raspberry Pi B+/2B/3B/3B+/4B](https://www.dfrobot.com/product-1211.html)
* [Gravity: DHT22 Temperature & Humidity Sensor](https://www.dfrobot.com)product-1102.html)
* [Gravity: Analog Electrical Conductivity Sensor /Meter V2](https://www.dfrobot.com/product-1123.html)
* [Gravity: Analog pH Sensor/Meter Kit V2](https://www.dfrobot.com/product-1782.html)


## Installation of the Base Home Assistant OS and DFRobot sensors
* Flash an SD card with a full installation of Home Assistant and boot the Raspberry PI (use Baleener Etcher).
* Install Tailscale and community SSH addons to facilitate ssh access to the pi.
*  Ensure ansible is installed on the host machine and run the ansible script in the ansible directory:
  `ansible-playbook -i 100.101.225.134, ha.yml`

## Tapo Webcam
Clone repository from https://github.com/JurajNyiri/HomeAssistant-Tapo-Control
scp custom_components/tapo_control to the config folder on the pi. NB by default scp copies into the user account so I found it easiest to tgz the file and then unpack at the other end.
* add the webcam to the network using the Tapo app.
* create a camera account on the camera with the Tapo app (Camera -> Device Settings -> Advanced Settings -> Camera Account)

## USB Webcam
* use [Motion Eye plugin](https://github.com/hassio-addons/addon-motioneye) to control the USB webcam.

## Creating the addon Docker Image
* Checkout `https://github.com/linucks/fu_sensors` to build the docker image (if updating)
* Edit the build.sh to set the SENSOR_DIR variable to the location of the above repository.
* Run the `build.sh` script to build and upload the Docker image to github.

## Power Strip
### Wifi
* Find a USB wifi dongle that is natively supported by HA (https://github.com/morrownr/USB-WiFi).
* Decided on 2.4GHz model from the pi hut https://thepihut.com/products/usb-wifi-adapter-for-the-raspberry-pi?variant=758603945
* Asus USB-N13

### Zigbee
* https://www.zigbee2mqtt.io/supported-devices/#e=energy

### Random Stuff
* Products: https://www.athom.tech/where-to-buy
* Products: https://www.mylocalbytes.com/
* ESP flasher: https://www.tindie.com/products/makerspacelt/esp-12f-flasher-v1/

## Networking
To configure the connection for a wifi not present at setup:
* https://github.com/home-assistant/operating-system/blob/dev/Documentation/network.md
* https://community.home-assistant.io/t/configure-wifi-connection/157201/29


## MQTT
### Security
- https://tasmota.github.io/docs/Securing-your-IoT-from-hacking/
- https://www.hivemq.com/blog/mqtt-security-fundamentals-securing-mqtt-systems/
- https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-the-mosquitto-mqtt-messaging-broker-on-ubuntu-16-04

## Equipment

- https://www.mylocalbytes.com/products/smart-plug-pm?variant=41600621510847

## Commands

`docker exec -it $(docker container ls | grep rpi-ardcli | cut -f1 -d " ") /bin/sh`

`ha network update wlan0 --ipv4-method auto --wifi-auth wpa-psk --wifi-mode infrastructure --wifi-ssid 'FARMURBAN' --wifi-psk 'XXX'``

`nmcli con show`
