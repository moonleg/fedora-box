#!/bin/bash

# Configuration
IMAGE_NAME="localhost/fedora-box:1.0"
CONTAINER_NAME="fedora-box"

echo "--=[ Preparing data directory ]=--"
mkdir -p data  
chmod 0755 data
chown -R 1000:1000 data 

echo "--=[ Cleaning up old container ]=--"
podman stop $CONTAINER_NAME 2>/dev/null || true
podman rm $CONTAINER_NAME 2>/dev/null || true

echo "--=[ Cleaning up old image versions ]=--"
podman image prune -f --filter "label=project=""$CONTAINER_NAME" --filter "dangling=true"
echo "Build and cleanup complete."

echo "--=[ Building $IMAGE_NAME ]=--"
if podman build --no-cache -t "$IMAGE_NAME" -f Containerfile .; then
    echo "Successfully built $IMAGE_NAME"
else
    echo "--=[ Build failed! ]=--"
    exit 1
fi

