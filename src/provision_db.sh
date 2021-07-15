#!/bin/bash

# Key server for missing signed keys in mongo installation files
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927

# Getting the mongo repo
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Updating our VM
sudo apt-get update -y

# Upgrading our VM
sudo apt-get upgrade -y

# Installing the mongo packages we want
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

# Changing the config files to make DB accessible
cd /etc
sudo rm -rf mongod.conf
sudo echo "
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
net:
  port: 27017
  bindIp: 0.0.0.0
" >> mongod.conf

# Restarting the db
sudo systemctl restart mongod
sudo systemctl enable mongod