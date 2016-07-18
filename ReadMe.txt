DevOps Challenge

Author: Kenneth Lynch
Date: 7-13-16

Included files: VagrantfileLinux,VagrantfileWin,checkip.ps1,bootstrap.ps1,checkip.sh, bootstrap.sh,setup.pl
Requirements: Perl 5

Setup file is called with arguments for either Linux or Windows machine. If Linux is chosen then a mysql password is also required. 

Setup file will make a copy of either VagrantfileLinux or VagrantfileWin and create Vagrantfile. If file exists, it will be overwritten. 

For Linux machine bash parameter for password will be modified to password provided. 

Setup file then executes "vagrant up" command to create virtual machine. 

Linux:

Vagrantfile is configured to create "ubuntu14-cloudimage" vm machine. After which it calls bootstrap.sh to install and configure Apache server. Finally it calls checkip.sh to check current IP against checkip.dyndns.org website and outputs results to file called ipcheck.txt. 

Warning during install of MySql can be ignored as the file is modified after install in bootstrap.sh

Vagrantfile configurations:
config.vm.box = "ubuntu14-cloudimage"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.hostname = "dev-test.localhost"
  config.vm.provision :shell, path: "checkip.sh"

boostrap.sh -p <password>
Accepts one argument for MySql root password.
Set DEBIAN_FRONTEND to noninteractive to prevent unnecessary errors. 
Use apt-get to update server.
Use apt-get to install Apache Server. 
Use apt-get to install MySql Server.
Use sed to modify /etc/mysql/my.cnf file to reflect required change in the warning during MySql install. 

checkip.sh
Get current datetime.
Execute wget command to get ip address. Results are formatted using sed. 
Use echo to output datetime and IP to file called ipcheck.txt formatted as <datetimestamp> | <ip addres>

Windows:
Vagrantfile is configured to create "mwrock/Windows2012R2" vm machine. Then it installs chocollatey. After which it calls bootstrap.ps1 to install apache, mysql and strawberry perl. Finally it calls checkip.ps1 to check current IP against checkip.dyndns.org website and outputs results to file called ipaddress.txt. 

Vagrantfile configurations:
config.vm.box = "mwrock/Windows2012R2"
  config.vm.box_url = "https://atlas.hashicorp.com/mwrock/boxes/Windows2012R2/versions/0.5.3/providers/virtualbox.box"
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
  config.vm.communicator = "winrm"
  # Your implementation goes here
  config.vm.provision "shell", inline: "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
  config.vm.provision "shell", path: "bootstrap.ps1"
  config.vm.provision "shell", path: "checkip.ps1"

boostrap.ps1
Use chocolatey commands to install ant, mysql and strawberry perl

checkip.ps1
Create webclient object. 
Place results of querying website into variable.
Combine current datetime with ip address recieved from checkip.dyndns.org. 
Use Set-Content to output datetime and IP to file called ipcheck.txt formatted as <datetimestamp> | <ip addres>
