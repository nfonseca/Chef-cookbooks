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

  user 'root'
  cwd  '/tmp/database'
  ignore_failure true
  code <<-EOH
    sudo -Eu oracle /tmp/database/runInstaller -responseFile /tmp/database/ora12.rsp -debug -waitForCompletion -ignoreSysPrereqs -ignoreInternalDriverError -silent
	returns [0, 6]
  EOH
	
end


# execute 'INSTALL_DB' do
  # user 		'oracle'
  # group		'oinstall'                      
  # command 	'/tmp/database/runInstaller -silent -responseFile /tmp/database/ora12.rsp -invPtrLoc /tmp/database/oraInst.loc -debug -waitForCompletion'
  # live_stream true
# end


# change from execute to bash
execute 'Post-Install 1/3 orainstRoot.sh' do
  user 'root'
  command '/u01/app/oraInventory/orainstRoot.sh'
  # retries 3
  # retry_delay 5
  # not_if 'ps aux | grep [D]oracle.installer'
end



# bash 'INSTALL_DB' do

  # user 'root'
  # cwd  '/u01'
  # code <<-EOH
    # /u01/app/oraInventory/orainstRoot.sh
	# returns [0, 6]
  # EOH
	
# end


execute 'Post-Install 2/3 root.sh' do
  user 'root'
  command '/u01/app/oracle/product/12.2.0/dbhome_1/root.sh'
  # retries 3
  # retry_delay 5
  # not_if 'ps aux | grep [D]oracle.installer'
end

# bash 'INSTALL_DB' do

  # user 'root'
  # cwd  '/u01'
  # code <<-EOH
    # /u01/app/oracle/product/12.2.0/dbhome_1/root.sh
	# returns [0, 6]
  # EOH
	
# end




# execute 'Post-Install 3/3 root.sh' do
  # user 'oracle'
  # command '/tmp/database/runInstaller -executeConfigTools -responseFile /tmp/database/ora12.rsp -silent -debug -ignorePrereqFailure'
  # returns [0, 6]
# end


bash 'INSTALL_CONFIG_TOOLS' do
  ignore_failure true
  user 'root'
  cwd  '/tmp/database'
  code <<-EOH
    sudo -Eu oracle /tmp/database/runInstaller -executeConfigTools -responseFile /tmp/database/ora12.rsp -silent
	returns [0, 6]
  EOH
	
end



# TEST DEPLOYMENT
execute 'SQL TEST' do
  user 'oracle'
  command 'echo "select HOST_NAME,VERSION,STARTUP_TIME,DATABASE_STATUS from  v$instance;" | sqlplus -s sys/vxrail123@ORCL'
end
