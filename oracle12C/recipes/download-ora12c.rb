#
# Cookbook:: oracle12C
# Recipe:: sys-templates
#
# Copyright:: 2018, The Authors, All Rights Reserved.


bash 'download_ora12c' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  wget http://192.168.10.153/Others/linuxx64_12201_database.zip
  unzip linuxx64_12201_database.zip
  EOH
end





