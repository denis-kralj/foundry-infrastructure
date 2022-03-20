#!/bin/bash

export FOUNDRY_USER_PASSWORD=password # change this

# add the user required for work
sudo adduser foundry --gecos "Found Ry,,," --disabled-password
usermod -aG sudo foundry
echo "foundry:$FOUNDRY_USER_PASSWORD" | sudo chpasswd

# login to user created
su - foundry

cd ~

# update system
echo $FOUNDRY_USER_PASSWORD | sudo -S apt-get update -y
echo $FOUNDRY_USER_PASSWORD | sudo apt-get upgrade -y

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
command -v nvm

# install stable node version
nvm install stable

# install pm2 runner
echo $FOUNDRY_USER_PASSWORD | sudo npm install pm2 -g

# make pm2 startup with the system
echo $FOUNDRY_USER_PASSWORD | sudo env PATH=$PATH:/home/foundry/.nvm/versions/node/v17.7.2/bin /home/foundry/.nvm/versions/node/v17.7.2/lib/node_modules/pm2/bin/pm2 startup systemd -u foundry --hp /home/foundry

# install nginx for reverse proxy
echo $FOUNDRY_USER_PASSWORD | sudo apt-get install nginx

# TODO: download and install foundry, copy configuration file, define config files