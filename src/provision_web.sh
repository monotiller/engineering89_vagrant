#!/bin/bash

# Let's automate all the steps from our morning session
# Updating our VM
sudo apt-get update -y

# Upgrading our VM
sudo apt-get upgrade -y

# Installing nginx
sudo apt-get install nginx -y

# Cheking status of nginx installation
systemctl status nginx
# We technically don't need to keep this in, but it's nice to see at least

# Installs node.js
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt install nodejs -y
node --version

# Installs the other dependencies
sudo apt-get install -y software-properties-common
sudo apt-get install -y python-software-properties

# Installs pm2 globally
sudo npm install pm2 -y -g

# Creates a variable for MongoDB
sudo echo 'export DB_HOST: "mongodb://192.168.10.150:27017/posts"' >> .profile

# Runs the sparta test program
# cd sync/app
# npm install -y
# node app.js