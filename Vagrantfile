# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.forward_port 80, 8080, :auto => true
  config.vm.forward_port 3306, 3306, :auto => true
  # config.vm.customize ["modifyvm", :id, "--memory", 1024, "--cpus", "2"]

  if RUBY_PLATFORM.include? "darwin"
    config.vm.network :hostonly, "33.33.33.10"
    config.vm.share_folder("v-root", "/vagrant", ".", :nfs => true)
  end

  config.vm.provision :chef_solo do |chef|
    # This path will be expanded relative to the project directory
    chef.cookbooks_path = "cookbooks"

    chef.add_recipe "vagrant_main"
    chef.json.merge!({
      "mysql" => {
        "server_root_password" => "vagrant",
        "server_repl_password" => "vagrant",
        "server_debian_password" => "vagrant"
      },
      "oh_my_zsh" => {
        :users => [
          {
            :login => 'vagrant',
            :theme => 'blinks',
            :plugins => ['git', 'gem']
          }
        ]
      }
    })
  end
end
