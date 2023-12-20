# ha_sensors
This repository is used to provision a Raspberry Pi with a Home Assistant installation for monitoring and controlling Farm Urban Edible Walls.

The Raspberry Pi requires an Arduino Shield for attaching the sensors:
* [Gravity: Arduino Shield for Raspberry Pi B+/2B/3B/3B+/4B](https://www.dfrobot.com/product-1211.html)
* [Gravity: DHT22 Temperature & Humidity Sensor](https://www.dfrobot.com/product-1102.html)
* [Gravity: PWM Infrared Carbon Dioxide Sensor (400-5000 ppm)](https://www.dfrobot.com/product-1549.html)
* [Gravity: Waterproof DS18B20 Temperature Sensor Kit](https://www.dfrobot.com/product-1354.html)
* [Gravity: Analog Ambient Light Sensor for Arduino / ESP32 / micro:bit / Raspberry Pi (1~6000 Lux)](https://www.dfrobot.com/product-1004.html)
* [Gravity: Analog Electrical Conductivity Sensor /Meter V2](https://www.dfrobot.com/product-1123.html)
* [Gravity: Analog pH Sensor/Meter Kit V2](https://www.dfrobot.com/product-1782.html)
* [Gravity: Analog Signal Isolator](https://www.dfrobot.com/product-1621.html)


## Installation of the Base Home Assistant OS and DFRobot sensors
* Use the [Raspberry Pi Imager](https://www.raspberrypi.com/software/) to flash an SD card with the Home Assistant OS.
* Insert SD card and second USB wifi dongle into the pi.
* On OSX: System Preferences -> Sharing -> Internet Sharing: On
* Plug ethernet cable into Mac and the Raspberry Pi.
* Go to: http://homeassistant.local:8123/ and do basic setup (user: fu)
* Go to user settings and enable Advanced Mode.
* Settings -> Add-ons -> ADD-ON STORE
  * Install [Advanced SSH Addon](https://github.com/hassio-addons/addon-ssh) and set `username` and `authorized_keys`. Turn off the Protected Mode for the addon (required to accces docker on the installation).
  * Install Tailscale, start the addon, and look in the logs to the the authorisation url, go there and authenticate.

## Network and AP setup
Settings -> System -> Network
* Set USB wifi card (WLP1SOU1U2) to IP4 to `automatic`

## Setup installation using the Ansible script
Install ansible on the host machine and then run the ansible script in the `ansible` directory of this repository with: `ansible-playbook -i 100.76.171.127, ha.yml`

## Final manual stup
* Goto Settings -> Devices & Services and click to automatically configure MQTT

## Setup of Tapo Webcam
* the addon is setup by the ansible script.
* add the webcam to the network using the Tapo app.
* create a camera account on the camera with the Tapo app (Camera -> Device Settings -> Advanced Settings -> Camera Account)
* If the above doesn't work: Devices and Services -> Add Integration -> Tapo: Cameras Control

## USB Webcam
* use [Motion Eye plugin](https://github.com/hassio-addons/addon-motioneye) to control the USB webcam.

## Creating the addon Docker Image
* Checkout `https://github.com/linucks/fu_sensors` to build the docker image (if updating)
* Edit the build.sh to set the SENSOR_DIR variable to the location of the above repository.
* Run the `build.sh` script to build and upload the Docker image to github.

## Power Strip
### Wifi
* Find a USB wifi dongle that is natively supported by HA (https://github.com/morrownr/USB-WiFi).
* Decided on 2.4GHz model from the pi hut: https://thepihut.com/products/usb-wifi-adapter-for-the-raspberry-pi?variant=758603945
* Asus USB-N13

# Create access point
https://github.com/mattlongman/Hassio-Access-Point

### Zigbee
* https://www.zigbee2mqtt.io/supported-devices/#e=energy

### Random Stuff
* Products: https://www.athom.tech/where-to-buy
* Products: https://www.mylocalbytes.com/
* ESP flasher: https://www.tindie.com/products/makerspacelt/esp-12f-flasher-v1/

### Cheap plugs but unsure if suitable
* https://www.diy.com/departments/arlec-smart-socket-3-gang-3-metre/9311644542407_BQ.prd
* https://uk.gosund.com/collections/smart-plugs-and-outlets/products/smart-power-strip-up9

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



192.168.99.1

