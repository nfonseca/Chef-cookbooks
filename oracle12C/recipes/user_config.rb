#
# Cookbook:: oracle12C
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


user 'oracle' do
  comment 		'oracle user'
  manage_home	true
  home 			'/home/oracle'
  shell 		'/bin/bash'
  gid 			'oinstall'
  password 		'$1$JJsvHslasdfjVEroftprNn4JHtDi'
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




