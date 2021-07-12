# Settimg up development environemnt
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