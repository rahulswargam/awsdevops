#!/bin/bash

# Load Environment Variables from credentials.env
export $(grep -v '^#' credentials.env | xargs)

# Install Required OS Packages and Tools
apt-get update && \
apt-get install -y jq curl unzip zip wget gnupg software-properties-common && \
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" | tee /etc/apt/sources.list.d/hashicorp.list && \
apt-get update && \
apt-get install -y terraform && \

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
./aws/install && \

# Ensure AWS CLI is Accessible
ln -s /usr/local/bin/aws /usr/bin/awss && \

# Cleanup Installation Files to Free Up Space
rm -rf awscliv2.zip aws && \
apt-get clean