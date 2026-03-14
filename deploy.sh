#!/bin/bash

COMPOSE_FILE="compose.yaml"
CONTAINER_NAME="fedora-box"

echo "--=[ Stopping and removing existing container ]=--"
podman-compose down

echo "--=[ Deploying new container instance ]=--"
if podman-compose --in-pod=0 up -d; then
    echo "--=[ Deployment Successful ]=--"
    podman ps --filter "name=$CONTAINER_NAME"
else
    echo "--=[ Deployment Failed! ]=--"
    exit 1
fi
