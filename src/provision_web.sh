#!/bin/bash

# Let's automate all the steps from our morning session
# Updating our VM
sudo apt-get update -y

# Upgrading our VM
sudo apt-get upgrade -y

# Installing nginx
sudo apt-get install nginx -y

# Installs node.js
sudo apt install node.js -y
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt install nodejs -y

# Installs pm2 globally
sudo npm install pm2 -y -g

# Checks status of nginx
systemctl status nginx

# Setting up the reverse proxy
cd /etc/nginx/sites-available
sudo rm -rf default
sudo echo "
server {
    listen 80;

    server_name _;

    location / {
        proxy_pass http://192.168.10.100:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
" >> default

# Sets the database location as an env variable
sudo nginx -t
cd /home/vagrant/
export DB_HOST=mongodb://192.168.10.150:27017/posts >> ~/.bashrc
source ~/.bashrc

# Runs the sparta test program
cd sync/app/
sudo npm install
sudo systemctl restart nginx
node seeds/seed.js
node app.js