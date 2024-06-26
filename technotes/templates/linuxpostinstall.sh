#!/bin/bash
apt-get -y update

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install kubectl
az aks install-cli

# Download and run images
docker pull fredsted/webhook.site
wget https://raw.githubusercontent.com/webhooksite/webhook.site/master/docker-compose.yml
docker-compose up