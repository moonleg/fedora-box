#!/bin/bash

# Configuration
source ./config.sh

echo -e "${GREEN}--=[ Preparing data directory ]=--${NC}"
mkdir -p data  
chmod 0755 data
chown -R 1000:1000 data 

echo -e "${GREEN}--=[ Cleaning up old container ]=--${NC}"
podman stop $CONTAINER_NAME 2>/dev/null || true
podman rm $CONTAINER_NAME 2>/dev/null || true

echo -e "${GREEN}--=[ Cleaning up old image versions ]=--${NC}"
podman image prune -f --filter "label=project=""$CONTAINER_NAME" --filter "dangling=true"
echo -e "${GREEN}--=[ Build and cleanup complete ]=--${NC}"

echo -e "${GREEN}--=[ Building $IMAGE_NAME ]=--${NC}"
if podman build --no-cache -t "$IMAGE_NAME" -f Containerfile .; then
    echo -e "${GREEN}--=[ Successfully built $IMAGE_NAME ]=--${NC}"
else
    echo -e "${RED}--=[ Build failed! ]=--${NC}"
    exit 1
fi

