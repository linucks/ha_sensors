#!/bin/bash
# A clone of: git clone git@github.com:linucks/fu_sensors.git
SENSOR_DIR=/opt/fu_sensors
IMAGE_REPO=ghcr.io/linucks
IMAGE_NAME=rpi-ardcli
IMAGE_TAG=latest

export CR_PAT=ghp_jmhtqAVdtLH595BoG6U6FYzsvSuS4e7zaR0oPhj6
echo $CR_PAT | docker login ghcr.io --username linucks --password-stdin

# Docker needs relative paths
cp -r $SENSOR_DIR/sensors/rpi_arduino_shield .

# Buld and push
#docker tag  $IMAGE_NAME $IMAGE_REPO/$IMAGE_NAME:$IMAGE_TAG 
docker build -t $IMAGE_REPO/$IMAGE_NAME:$IMAGE_TAG . && \
docker push $IMAGE_REPO/$IMAGE_NAME:$IMAGE_TAG  

rm -rf rpi_arduino_shield
