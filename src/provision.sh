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