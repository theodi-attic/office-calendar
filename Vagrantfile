# -*- mode: ruby -*-
# vi: set ft=ruby :

how_many = 2

require "yaml"
y = YAML.load File.open ".chef/rackspace_secrets.yaml"

Vagrant.configure("2") do |config|

  config.butcher.knife_config_file = '.chef/knife.rb'
  config.omnibus.chef_version = :latest

  config.vm.define :calendar_theodi_org_01 do |cal_01_config|
    cal_01_config.vm.box      = "dummy"
    cal_01_config.vm.hostname = "calendar-01"

    cal_01_config.ssh.private_key_path = "./.chef/id_rsa"
    cal_01_config.ssh.username         = "root"

    cal_01_config.vm.provider :rackspace do |rs|
      rs.username        = y["username"]
      rs.api_key         = y["api_key"]
      rs.flavor          = /512MB/
      rs.image           = /Precise/
      rs.public_key_path = "./.chef/id_rsa.pub"
      rs.endpoint        = "https://lon.servers.api.rackspacecloud.com/v2"
      rs.auth_url        = "lon.identity.api.rackspacecloud.com"
    end

    cal_01_config.vm.provision :shell, :inline => "curl -L https://www.opscode.com/chef/install.sh | bash"

    cal_01_config.vm.provision :chef_client do |chef|
      chef.node_name              = "calendar-01"
      chef.environment            = "production"
      chef.chef_server_url        = "https://chef.theodi.org"
      chef.validation_client_name = "chef-validator"
      chef.validation_key_path    = ".chef/chef-validator.pem"
      chef.run_list               = chef.run_list = [
          "role[calendar]"
      ]
    end
  end

  config.vm.define :calendar_theodi_org_02 do |cal_02_config|
    cal_02_config.vm.box      = "dummy"
    cal_02_config.vm.hostname = "calendar-02"

    cal_02_config.ssh.private_key_path = "./.chef/id_rsa"
    cal_02_config.ssh.username         = "root"

    cal_02_config.vm.provider :rackspace do |rs|
      rs.username        = y["username"]
      rs.api_key         = y["api_key"]
      rs.flavor          = /512MB/
      rs.image           = /Precise/
      rs.public_key_path = "./.chef/id_rsa.pub"
      rs.endpoint        = "https://lon.servers.api.rackspacecloud.com/v2"
      rs.auth_url        = "lon.identity.api.rackspacecloud.com"
    end

    cal_02_config.vm.provision :shell, :inline => "curl -L https://www.opscode.com/chef/install.sh | bash"

    cal_02_config.vm.provision :chef_client do |chef|
      chef.node_name              = "calendar-02"
      chef.environment            = "production"
      chef.chef_server_url        = "https://chef.theodi.org"
      chef.validation_client_name = "chef-validator"
      chef.validation_key_path    = ".chef/chef-validator.pem"
      chef.run_list               = chef.run_list = [
          "role[calendar]"
      ]
    end
  end
end
