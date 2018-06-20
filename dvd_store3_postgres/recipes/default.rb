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
 package_name ['git', 'postgresql-server.x86_64']
 action [:install]
end

execute 'git clone dvdstore' do
  command 'git clone https://github.com/dvdstore/ds3.git'
end