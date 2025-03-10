#!/bin/bash

# Check if an image name is passed as an argument
if [ -z "$1" ]; then
  echo "No image name provided. Using default name: sr-jenkins"
  IMAGE_NAME="sr-jenkins"
else
  IMAGE_NAME="$1"
fi

# Set environment variables from credentials.env
set -a
source credentials.env
set +a

# Build the Docker image with the specified (or default) name
docker build --build-arg JENKINS_USER=$JENKINS_USER --build-arg JENKINS_PASS=$JENKINS_PASS --build-arg JENKINS_FULL_NAME="$JENKINS_FULL_NAME" --build-arg JENKINS_EMAIL="$JENKINS_EMAIL" -t $IMAGE_NAME .