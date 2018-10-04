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
    export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1/
    export ORACLE_SID=ORCL
    export TNS_ADMIN=/u01/app/oracle/product/12.2.0/dbhome_1/network/admin/
    EOH
	
end

