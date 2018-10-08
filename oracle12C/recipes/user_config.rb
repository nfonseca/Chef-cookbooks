#
# Cookbook:: oracle12C
# Recipe:: user_config
#
# Copyright:: 2018, The Authors, All Rights Reserved.

Chef::Recipe.send(:include, OpenSSLCookbook::RandomPassword)
password = 'vxrail123'
salt = random_password(length: 10)
crypt_password = password.crypt("$6$#{salt}")


user 'oracle' do
  comment 		'oracle user'
  manage_home	true
  home 			'/home/oracle'
  shell 		'/bin/bash'
  password 		crypt_password
  username      'oracle'
end


group 'oinstall' do
  append                false 
  group_name            'oinstall'
  members               'oracle'
  action                :create
end


group 'dba' do
  append                false 
  group_name            'dba'
  members               'oracle'
  action                :create
end



# Env Variables

bash 'ENV' do

  code <<-EOH
    echo 'ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1' >> /home/oracle/.bash_profile
    echo 'ORACLE_SID=ORCL' >> /home/oracle/.bash_profile
	echo 'TNS_ADMIN=/u01/app/oracle/product/12.2.0/dbhome_1/network/admin' >> /home/oracle/.bash_profile
	echo 'PATH=$PATH:$ORACLE_HOME/bin' >> /home/oracle/.bash_profile
	echo 'export ORACLE_HOME'  >> /home/oracle/.bash_profile
	echo 'export ORACLE_SID'  >> /home/oracle/.bash_profile
	echo 'export TNS_ADMIN'  >> /home/oracle/.bash_profile
	echo 'export PATH'  >> /home/oracle/.bash_profile
    EOH
	
end

