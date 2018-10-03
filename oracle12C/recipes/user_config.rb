#
# Cookbook:: oracle12C
# Recipe:: default
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
  gid 			'oinstall'
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




