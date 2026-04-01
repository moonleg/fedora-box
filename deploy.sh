#!/bin/bash

source ./config.sh

echo -e "${GREEN}--=[ Stopping and removing existing container ]=--${NC}"
podman stop "$CONTAINER_NAME"

echo -e "${GREEN}--=[ Deploying new container instance ]=--${NC}"
if podman-compose --in-pod=false up -d; then
    echo -e "${BLUE}--=[ Deployment Successful ]=--${NC}"
    podman ps --filter "name=$CONTAINER_NAME"
else
    echo -e "${RED}--=[ Deployment Failed! ]=--${NC}"
    exit 1
fi
