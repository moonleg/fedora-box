#!/bin/bash

source ./config.sh

STATUS=$(podman inspect "$CONTAINER_NAME" --format '{{.State.Status}}' 2>/dev/null)

if [ -z "$STATUS" ]; then
    echo -e "${GREEN}--=[ Container '$CONTAINER_NAME' does not exist. Deploying now... ]=--${NC}"
    ./deploy.sh 
    STATUS=$(podman inspect "$CONTAINER_NAME" --format '{{.State.Status}}' 2>/dev/null)
fi

if [ "$STATUS" != "running" ]; then
    echo -e "${GREEN}--=[ Starting $CONTAINER_NAME... ]=--${NC}"
    podman start "$CONTAINER_NAME"
fi

echo ""
echo -e "${BLUE}--=[ Entering $CONTAINER_NAME ]=--${NC}"
echo ""
podman exec -it "$CONTAINER_NAME" /bin/zsh
