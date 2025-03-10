#!/bin/bash

# Load Environment Variables from credentials.env
export $(grep -v '^#' credentials.env | xargs)

# Load Parameters from params.properties
source params.properties

echo "Enter Container Name:"
read CONTAINER_NAME

if [ -z "$CONTAINER_NAME" ]; then
  CONTAINER_NAME="sr-jenkins"
  echo "Default Container Name Taken: $CONTAINER_NAME"
fi

echo "Enter Image Name to Use:"
read IMAGE_NAME

if [ -z "$IMAGE_NAME" ]; then
  IMAGE_NAME="sr-jenkins"
fi

docker run -d --name $CONTAINER_NAME -p $JENKINS_PORT:8080 --env-file credentials.env $IMAGE_NAME

# Run fetch_secrets.sh inside the container after startup
docker exec $CONTAINER_NAME /usr/local/bin/fetch_secrets.sh