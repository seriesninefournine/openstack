# -*- mode: ruby -*-
# vim: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

$script = <<-SCRIPT

echo "network:
        version: 2
        renderer: networkd
        ethernets:
                enp0s8:
                        dhcp4: no
                        addresses: [192.168.10.100/24]
                        gateway4: 192.168.10.1
                        nameservers:
                                addresses: [192.168.10.1,8.8.8.8]" > /etc/netplan/01-network-card.yaml

netplan apply

SCRIPT

Vagrant.configure("2") do |config|
      config.vm.box = 'ubuntu/focal64'
      config.vm.box_url = 'https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-vagrant.box'
      config.vm.box_download_checksum = '3a0ba3aa3d62980f33805551ea613f8082f75112f379044809ca2fb75f0d9f6b'
      config.vm.box_download_checksum_type = 'sha256'

      config.vm.hostname = 'DevStack'
      config.vm.network "public_network", bridge: "wlp0s20f3", auto_config: false
      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "8192"]
      end
      
      config.vm.provision "shell",
        run: "always",
        inline: $script

      #config.vm.provision "shell", path: "startup_script.sh"
end