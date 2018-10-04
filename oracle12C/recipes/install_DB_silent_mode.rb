#
# Cookbook:: oracle12C
# Recipe:: install_DB_silent_mode
#
# Copyright:: 2018, The Authors, All Rights Reserved.


template '/etc/hosts' do
  source 'hosts.erb'
  owner 'root'
  group 'root'
  mode '0744'
end

template '/tmp/database/ora12.rsp' do
  source 'ora12.erb'
  owner 'oracle'
  group 'oinstall'
  mode '0755'
end


template '/tmp/database/oraInst.loc' do
  source 'oraInst.erb'
  owner 'oracle'
  group 'oinstall'
  mode '0755'
end


bash 'INSTALL_DB' do

  user 'oracle'
  cwd  '/tmp/database'
  code <<-EOH
    /tmp/database/runInstaller -silent -responseFile /tmp/database/ora12.rsp -invPtrLoc oraInst.loc
  EOH
	
end

