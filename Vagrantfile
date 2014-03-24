
Vagrant.configure("2") do |config|

  config.vm.box = "centOS"
  config.vm.box_url = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"
  config.vm.network "forwarded_port", guest: 8080, host: 8980

  config.berkshelf.enabled = true
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "nodejs"
    chef.add_recipe "redisio::install"
    chef.add_recipe "redisio::enable"
    chef.json = {
      "nodejs" => {
        "version" => "0.10.10" # AWS node version
      },
      "nodejs::npm" => {
        "version" => "1.2.25" # AWS npm version
      }
    }
  end
end
