servers=[
  {
    :hostname => "server",
    :ip => "192.168.100.10",
    :box => "generic/ubuntu2004",
    :ram => 4096,
    :cpu => 2
  },
  {
    :hostname => "workstation",
    :ip => "192.168.100.11",
    :box => "generic/ubuntu2004",
    :ram => 4096,
    :cpu => 2
  }
]
Vagrant.configure(2) do |config|
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip]
      if machine[:hostname] == "server"
        node.vm.provision "shell",
          inline: "curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-server -v 15; cinc-server-ctl reconfigure"
      elsif machine[:hostname] == "workstation"
        node.vm.provision "shell",
          inline: "curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-workstation -v 23"
      # else
      #   node.vm.provision "docker"
      #   node.vm.provision "shell",
      #     inline: "docker swarm join --token `cat /vagrant/workertoken` 192.168.100.10:2377; ln -s /vagrant/DATA /DATA"
      end
      node.vm.provider "libvirt" do |vb|
        vb.memory = machine[:ram]
        vb.cpus = machine[:cpu]
      end
      node.vm.synced_folder './data', '/vagrant'
    end
  end
end
