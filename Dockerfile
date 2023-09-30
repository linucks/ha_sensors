FROM homeassistant/aarch64-base-python
#FROM homeassistant/amd64-base-python

LABEL \
  io.hass.version="2023.9.3" \
  io.hass.type="addon" \
  io.hass.arch="aarch64"

ENV BASEDIR=/sensors
ENV RPIDIR=$BASEDIR/rpi
RUN mkdir $BASEDIR

# Copy data for add-on
COPY rpi $RPIDIR
COPY rpi_arduino_shield $BASEDIR/rpi_arduino_shield

WORKDIR $RPIDIR
RUN pip3 install -r requirements.txt

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
# command list
CMD [ "./rpi_mqtt_sensors.py" ]
