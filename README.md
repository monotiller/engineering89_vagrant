# Setting up development environemnt
![](images/virtualisation.png)
## Installation of Vagrant, Virtual box and Ruby
### Vagrant Commands
- `vagrant up` to launch the VM
- `vagrant destroy` to delete everything
- `vagrant reload` to, well, reload
- `vagrant halt` to stop the vm

## Getting in to Vagrant
- Let's `ssh` into our VM and launch nginx web-server
- Use `apt-get` package manager in Linux - for mac `brew`
- `apt-get-` is used to install and uninstall any packages needed
- To use the command in `admin` mode we can use `sudo` before the command
- `sudo apt-get upgrade -y`
- `sudo apt-get update -y`
- `ping www.spartaglobal.com`
- To work in `admin mode` all the time (don't do this) `sudo -su`
- We will install nginx in our guest machine
- Launch the default nginx page in host machine's browser
- To come out of your vm `exit`
- Install nginx `sudo apt-get install nginx -y`
- Checking status of nginx `systemctl status nginx`
- Or restart `systemctl restart nginx` or just start `systemctl start nginx`

## Making it easier to get in to nginx
1. Install the plugin: `vagrant plugin install vagrant-hostsupdater`
2. Add this line of code into Vagrantfile `config.hostsupdater.aliases = ["development.local"]`
3. Reload vagrant
4. `vagrant ssh`
5. `nginx status active` should load nginx in the browser

## Automation of installation
- Create a file calleed `provision.sh`
- `sudo apt-get update -y`
- `sudo apt-get upgrade -y`
- `sudo apt-get install nginx`
- `systemctl status nginx`

To run `provision.sh` we neeed to give the file permission and make this file executable. To change permission we euse `chmod` with required permission then file name
- `chmod -x`

Check out the `provision.sh` file to check out the changes so far, it's changed a few times since it was first written!

## Changing the port to run the apps without the need for entering it in every time
In the folder `/etc/nginx/sites-available` there is a file called `default`. In here is where we want to put the configuration for the ports and addresses to listen on!

```nginx
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
```
After doing this we may enter in: `sudo nginx -t` to test the above configuration file. If we get this message:
```conosle
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```
Then everything is ok!

## MongoDB
- Create another VM called DB and install MongoDB in it
- Then create an env variable called `export DB_HOST=mongodb://192.168.10.150:27017/posts >> ~/.bashrc` inside web vm to connect to db
- http://192.168.10.100/posts

[Multi-Machine](https://www.vagrantup.com/docs/multi-machine)

- After starting both VMs you will need to SSH into the `db` VM. Then do: `sudo nano /etc/mongod.conf` and change the ip to `0.0.0.0`.
- Then run `sudo systemctl restart mongod` to restart MongoDB
- Then run `sudo systemctl enable mongod` to enable the service
- Finally run `sudo systemctl status mongod` to check it's running!

Then move back to the `web` VM
- Move to the app folder
- `npm start`