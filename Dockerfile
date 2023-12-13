# Need to use debian image or otherwise requried symbols from gcc aren't present
FROM homeassistant/aarch64-base-debian
# FROM homeassistant/amd64-base-debian

# LABEL \
#   io.hass.version="2023.9.3" \
#   io.hass.type="addon" \
#   io.hass.arch="aarch64"

# ARG CLITAR=arduino-cli_0.34.2_Linux_64bit.tar.gz
ARG CLITAR=arduino-cli_0.34.2_Linux_ARM64.tar.gz
# arduino-cli_0.34.2_Linux_ARMv7.tar.gz
ARG ARDLIBDIR=/root/Arduino/libraries
ARG BASEDIR=/rpi_arduino_shield

COPY ./rpi_arduino_shield $BASEDIR
WORKDIR $BASEDIR

ENV ARDUINO_DIRECTORIES_USER=$BASEDIR/arduino-cli
ENV ARDUINO_DIRECTORIES_DATA=$ARDUINO_DIRECTORIES_USER/data
ENV ARDUINO_DIRECTORIES_DOWNLOADS=$ARDUINO_DIRECTORIES_USER/staging
ARG ARDUINO_LIBDIR=$ARDUINO_DIRECTORIES_USER/libraries

RUN mkdir $ARDUINO_DIRECTORIES_USER

#RUN apk add git
RUN apt-get update \
  && apt-get install -y git \
  && apt-get install -y vim 

RUN curl -LO https://github.com/arduino/arduino-cli/releases/download/0.34.2/${CLITAR} \
  && tar xvzf ${CLITAR} \
  && rm ${CLITAR} LICENSE.txt \
  && mv arduino-cli /usr/bin

# RUN arduino-cli core install esp32:esp32 --additional-urls https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
RUN arduino-cli config init
RUN arduino-cli core update-index
RUN arduino-cli core install  arduino:avr

# For SEN0137 Temperature and Humidity sensor
RUN arduino-cli lib install "DHT sensor library for ESPx"
# For DFR0198: Waterproof DS18B20 Sensor Kit
RUN arduino-cli lib install OneWire
# JSON
RUN arduino-cli lib install ArduinoJson
# DEFOBOT EC
RUN git clone https://github.com/linucks/DFRobot_EC.git $ARDUINO_LIBDIR/DFRobot_EC
# DEFOBOT pH
RUN git clone https://github.com/linucks/DFRobot_PH.git $ARDUINO_LIBDIR/DFRobot_PH

