#!/bin/bash

# Key server for missing signed keys in mongo installation files
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927

# Installing MongoDB
sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -

# Creating a list file for MongoDB
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu%20xenial/mongodb-org/5.0%20multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

# Updating our VM
sudo apt-get update -y

# Upgrading our VM
sudo apt-get upgrade -y

# Installing the MongoDB packages
sudo apt-get install -y mongodb-org

echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

sudo systemctl daemon-reload

# Running MongoDB
sudo mongodb
sudo systemctl start mongod
sudo systemctl status mongod