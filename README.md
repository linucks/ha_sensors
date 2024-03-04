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
There are currently issues with the network manager interface when using external wifi. One bug is described here:
https://github.com/home-assistant/supervisor/issues/4383#issuecomment-1963036433

Another issue that we encountered was that the wifi connection disconnects and is then disabled and needs to be manually renabled.

Potentially this bug:
https://github.com/home-assistant/supervisor/issues/3674
https://github.com/home-assistant/operating-system/issues/2720


For this reason, we've had to ditch the HA OS and will use a standard Linux OS on the RPI and add the HA Supervisor.

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
* Settings -> System -> Network:
  * Set USB wifi card (WLP1SOU1U2) to IP4 to `automatic`. We use this for the connection to the Wifi as it doesn't support AP mode so we use the internal card as the AP (see `tasks\setup_ap.yml`)

## Setup installation using the Ansible script
* Install ansible on the host machine.
* Edit the ansible files in the ansible directory to set:
  * The MAC/HOSTNAME/IP for the ip camera and plugs in `tasks/setup_ap.yml`
  * Edit `files//mqtt.yml` to set which sensors are present.
* Run the ansible script in the `ansible` directory of this repository with: `ansible-playbook -i 100.76.171.127, ha.yml`

## Final manual stup
* Goto Settings -> Devices & Services and click to automatically configure MQTT

## Setup of Tapo Webcam
* the addon is setup by the ansible script.
* create a camera account on the camera with the Tapo app (Camera -> Device Settings -> Advanced Settings -> Camera Account).
* add the webcam to the network using the Tapo app.
* If the above doesn't work: Devices and Services -> Add Integration -> Tapo: Cameras Control

## USB Webcam
* use [Motion Eye plugin](https://github.com/hassio-addons/addon-motioneye) to control the USB webcam.

## Creating the addon Docker Image
* Checkout `https://github.com/linucks/fu_sensors` to build the docker image (if updating)
* Edit the build.sh to set the SENSOR_DIR variable to the location of the above repository.
* Run the `build.sh` script to build and upload the Docker image to github.

## Power Plugs
### Wifi
* Find a USB wifi dongle that is natively supported by HA (https://github.com/morrownr/USB-WiFi) - this means that it has an in-kernel driver, and supports AP mode.
* Decided on 2.4GHz model from the [Pi Hut](https://thepihut.com/products/usb-wifi-adapter-for-the-raspberry-pi?variant=758603945), this has a supported driver but doesn't support AP mode, so this is used for for  Pi to connect to the Wifi, and the internal USB card serves as the AP.
* Could try [Panda PAU03](https://www.amazon.co.uk/Panda-Ultra-150Mbps-Wireless-Adapter/dp/B00762YNMG/) - might have in kernel driver and support AP mode.

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


## Useful Commands

* Enter shell on container: `docker exec -it $(docker container ls | grep rpi-ardcli | cut -f1 -d " ") /bin/sh`
* Manually set network parameters: `ha network update wlan0 --ipv4-method auto --wifi-auth wpa-psk --wifi-mode infrastructure --wifi-ssid 'FARMURBAN' --wifi-psk 'XXX'``
* Network on the pi: `nmcli con show`
* Getting the slug for an addon: `ha addons`
* Getting options for an addon from the command-line:
```
curl \
-sSL \
-H "Authorization: Bearer $SUPERVISOR_TOKEN" \
http://supervisor/addons/30e576d0_hassio-access-point/info \
| jq
```


```
curl  \
-sSL  \
-H "Authorization: Bearer $SUPERVISOR_TOKEN"  \
-X POST  \
http://supervisor/addons/30e576d0_hassio-access-point/options  \
-d '{"options": {"addon_option1": 1, "addon_option2": 2}'


```

