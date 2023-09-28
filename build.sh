#!/bin/bash
IMAGE_REPO=ghcr.io/linucks
IMAGE_NAME=rpisensors
IMAGE_TAG=latest
SENSOR_DIR=/opt/fu_sensors

export CR_PAT=ghp_WIs2KeqQDmn1jmhtlKp17R6PQ29UXHYiOr2aECW7
echo $CR_PAT | docker login ghcr.io -u linucks --password-stdin

# Docker needs relative paths
ln -s $SENSOR_DIR/sensors/rpi .
ln -s $SENSOR_DIR/sensors/rpi_arduino_shield .

# Buld and push
docker build -t $IMAGE_REPO/$IMAGE_NAME:$IMAGE_TAG . \ &&
 docker push $IMAGE_REPO/$IMAGE_NAME:$IMAGE_TAG  
