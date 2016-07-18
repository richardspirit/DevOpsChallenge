# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "mwrock/Windows2012R2"
  config.vm.box_url = "https://atlas.hashicorp.com/mwrock/boxes/Windows2012R2/versions/0.5.3/providers/virtualbox.box"
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
  config.vm.communicator = "winrm"
  # Your implementation goes here
  config.vm.provision "shell", inline: "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
  config.vm.provision "shell", path: "bootstrap.ps1"
  config.vm.provision "shell", path: "checkip.ps1"
end
