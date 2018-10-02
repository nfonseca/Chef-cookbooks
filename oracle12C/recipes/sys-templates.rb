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



