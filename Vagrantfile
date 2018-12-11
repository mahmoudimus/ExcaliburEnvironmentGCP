# -*- mode: ruby -*-
#
# vi: set ft=ruby :
# vim: ts=2

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder "~/Desktop", "/home/vagrant/Desktop"

  config.vagrant.plugins = "vagrant-disksize"
  config.disksize.size = "50GB"
  
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = 5120
    vb.cpus = 2
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install --yes python
  SHELL
  
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./playbook/playbook.yml"
  end
end
