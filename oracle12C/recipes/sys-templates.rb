#
# Cookbook:: oracle12C
# Recipe:: sys-templates
#
# Copyright:: 2018, The Authors, All Rights Reserved.


template '/etc/sysctl.conf' do
  source 'sysctl-conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end


template '/etc/security/limits.conf' do
  source 'limits-conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end



execute 'sysctl1' do
  command 'sysctl -p'
end

execute 'sysctl2' do
  command 'sysctl -a'
end

# Update a package or packages on your system

execute 'yum_update' do
  command '/usr/bin/yum update -y'
end

# disable the firewall

service 'firewalld' do
  service_name 'firewalld'
  action [:disable, :stop]
end


# Create the dirs u01 and u02



directory 'u01' do
  owner 'oracle'
  group 'oinstall'
  mode '0755'
  path '/u01'
  action :create
end


# directory 'u02' do
  # owner 'oracle'
  # group 'oinstall'
  # mode '0755'
  # path '/u02'
  # action :create
# end