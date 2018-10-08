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


# bash 'INSTALL_DB' do

  # user 'oracle'
  # cwd  '/tmp/database'
  # code <<-EOH
    # /tmp/database/runInstaller -silent -responseFile /tmp/database/ora12.rsp  -debug -waitForCompletion
  # EOH
	
# end


execute 'INSTALL_DB' do
  user 'oracle'
  command '/tmp/database/runInstaller -silent -responseFile /tmp/database/ora12.rsp  -debug -waitForCompletion'
end



execute 'Post-Install 1/3 orainstRoot.sh' do
  user 'root'
  command '/u01/app/oraInventory/orainstRoot.sh'
  not_if 'sleep 10000', :timeout => 10
end


execute 'Post-Install 2/3 root.sh' do
  user 'root'
  command '/u01/app/oracle/product/12.2.0/dbhome_1/root.sh'
  not_if 'sleep 10000', :timeout => 10
end

execute 'Post-Install 3/3 root.sh' do
  user 'oracle'
  command '/tmp/database/runInstaller -executeConfigTools -responseFile /tmp/database/ora12.rsp -silent -debug'
  not_if 'sleep 10000', :timeout => 10
end
