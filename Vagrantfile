Vagrant.configure("2") do |config|
  config.vm.define "web", primary: true do |web|
    config.vm.box = "ubuntu/xenial64"
    # Let's connect to nginx using private ip
    config.vm.network "private_network", ip: "192.168.10.100"
    # We would like to load this ip using our host machine's browser to view default nginx page
    config.hostsupdater.aliases = ["web.local"]
    # If the plugin is installed correctly and file is updated with vagrant destroy then we should be able to see nginx page in the browser with http://development.local
    # Choosing a file or folder to sync
    config.vm.synced_folder "sync/web/", "/home/vagrant/sync", create: true
    # Automatically running the install script on initial setup
    config.vm.provision :shell, path: "src/provision_web.sh"
  end

  config.vm.define "db" do |db|
    config.vm.box = "ubuntu/xenial64"
    # Let's connect to nginx using private ip
    config.vm.network "private_network", ip: "192.168.10.150"
    # We would like to load this ip using our host machine's browser to view default nginx page
    config.hostsupdater.aliases = ["db.local"]
    # If the plugin is installed correctly and file is updated with vagrant destroy then we should be able to see nginx page in the browser with http://development.local
    # Choosing a file or folder to sync
    config.vm.synced_folder "sync/db/", "/home/vagrant/sync", create: true
    # Automatically running the install script on initial setup
    config.vm.provision :shell, path: "src/provision_db.sh"
  end
end
