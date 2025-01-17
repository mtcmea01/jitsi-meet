#!/bin/bash

#host : t1.velaconference.business

#Announce Variables 
myhostname="t1.velaconference.business" #edit this manually and enter your URL
myip=`curl -4 ifconfig.me`

#Starting script
hostnamectl set-hostname $myhostname
apt update
apt -y install nginx wget lua5.2 certbot python3-certbot-nginx git curl
echo "$myip $myhostname" >> /etc/hosts

# Update the package list
apt-get update

# Update the package list
sudo apt-get update

# Install Git, Docker, and Docker-compose if they are not already installed
if ! command -v git &> /dev/null; then
    sudo apt-get install -y git
fi

if ! command -v docker &> /dev/null; then
    sudo apt-get install -y docker.io
fi

if ! command -v docker-compose &> /dev/null; then
    sudo apt-get install -y docker-compose
fi

# Navigate to your projects directory (change this to your desired directory)
mkdir /meet
cd /meet

REPO_URL="https://github.com/kushalg-1212/jitsi-meet.git"
REPO_NAME="jitsi-meet"

# Clone the repo if it doesn't exist, or pull the latest changes if it does
if [ ! -d "$REPO_NAME" ]; then
    git clone $REPO_URL
    cd $REPO_NAME
else
    cd $REPO_NAME
    git push
    git pull
fi

# Stop all running Docker containers
docker stop $(docker ps -aq)

# Build the Docker image
docker build -t my-app .

# Stop running containers and services from docker-compose, if any
docker-compose down

# Start the services defined in the docker-compose.yml file in detached mode
docker-compose up -d
