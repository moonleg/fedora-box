#!/bin/bash

CONTAINER_NAME="fedora-box"

STATUS=$(podman inspect "$CONTAINER_NAME" --format '{{.State.Status}}' 2>/dev/null)

if [ -z "$STATUS" ]; then
    echo "Container '$CONTAINER_NAME' does not exist. Deploying now..."
    ./deploy.sh 
    STATUS=$(podman inspect "$CONTAINER_NAME" --format '{{.State.Status}}' 2>/dev/null)
fi

if [ "$STATUS" != "running" ]; then
    echo "Starting $CONTAINER_NAME..."
    podman start "$CONTAINER_NAME"
fi

echo ""
echo "--=[ Entering $CONTAINER_NAME ]=--"
podman exec -it "$CONTAINER_NAME" /bin/zsh
