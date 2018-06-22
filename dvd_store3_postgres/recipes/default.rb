#
# Cookbook:: dvd_store3_postgres
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# install git


# multiple packages 
# package %w(mysql-server mysql-common mysql-client)

#package 'git' do
#  action [:install]
#end

#package %w(package1 package2 package3) do
#	version %w(1.2 1.4 1.5)
#	action :install
#end


package 'Base Line' do
 package_name ['git', 'mariadb', 'mariadb-server','httpd']
 action [:install]
end


service "mariadb" do
  action :start
end

service "httpd" do
  action :start
end


execute 'git clone dvdstore' do
  cwd '/opt'
  command 'git clone https://github.com/dvdstore/ds3.git'
end



user 'web' do
  comment 'web user for dvdstore'
  uid '1001'
  manage_home true
  home '/home/web'
  shell '/bin/bash'
  password '$1$pCSCBK/r$8XjqMuFLO0gOg8LAmic9h1'
end

# user web and pass web
#systemctl start mariadb.service 
# need to create web user for mysql in the db