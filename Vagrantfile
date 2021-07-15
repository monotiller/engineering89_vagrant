
def set_env vars
  command = <<~HEREDOC
  echo "Setting Environment Variables"
  source ~/.bashrc
  HEREDOC
  
  
  
  vars.each do |key, value|
  command += <<~HEREDOC
  if [ -z "$#{key}" ]; then
  echo "export #{key}=#{value}" >> ~/.bashrc
  fi
  HEREDOC
  end
  
  
  
  return command
  end

Vagrant.configure("2") do |config|
    config.vm.define "db" do |db|
    db.vm.box = "ubuntu/xenial64"
    # Let's connect to nginx using private ip
    db.vm.network "private_network", ip: "192.168.10.150"
    # We would like to load this ip using our host machine's browser to view default nginx page
    db.hostsupdater.aliases = ["db.local"]
    # If the plugin is installed correctly and file is updated with vagrant destroy then we should be able to see nginx page in the browser with http://development.local
    # Choosing a file or folder to sync
    db.vm.synced_folder "sync/db/", "/home/vagrant/sync", create: true
    # Automatically running the install script on initial setup
    db.vm.provision :shell, path: "src/provision_db.sh"
  end

  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/xenial64"
    # Let's connect to nginx using private ip
    web.vm.network "private_network", ip: "192.168.10.100"
    # We would like to load this ip using our host machine's browser to view default nginx page
    config.hostsupdater.aliases = ["web.local"]
    # If the plugin is installed correctly and file is updated with vagrant destroy then we should be able to see nginx page in the browser with http://development.local
    # Choosing a file or folder to sync
    web.vm.synced_folder "sync/web/", "/home/vagrant/sync", create: true
    # Automatically running the install script on initial setup
    web.vm.provision "shell", path: "src/provision_web.sh"
    web.vm.provision "shell", inline: set_env({ DB_HOST: "mongodb://192.168.10.150:27017/posts" })
  end
end
