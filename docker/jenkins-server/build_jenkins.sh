#!/bin/bash

echo "Enter Name of the Image:"
read IMAGE_NAME

if [ -z "$IMAGE_NAME" ]; then
  IMAGE_NAME="sr-jenkins"
  echo "Default Image Name Taken: $IMAGE_NAME"
fi

docker build -t $IMAGE_NAME .