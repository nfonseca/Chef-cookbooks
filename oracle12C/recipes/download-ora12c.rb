#
# Cookbook:: oracle12C
# Recipe:: sys-templates
#
# Copyright:: 2018, The Authors, All Rights Reserved.

ora_path = '/tmp/linuxx64_12201_database.zip'

bash 'download_ora12c' do
  live_stream true
  user 'root'
  cwd '/tmp'
  code <<-EOH
  wget http://192.168.10.153/Others/linuxx64_12201_database.zip
  unzip -o linuxx64_12201_database.zip
  EOH
  not_if { ::File.exist?(ora_path) } # guard to prevent file from being downladed if it exists
end


bash 'install-dev-libs' do
  live_stream true 
  user 'root'
  code <<~EOH
  yum install -y binutils.x86_64 compat-libcap1.x86_64 gcc.x86_64 gcc-c++.x86_64 glibc.i686 glibc.x86_64 \
  glibc-devel.i686 glibc-devel.x86_64 ksh compat-libstdc++-33 libaio.i686 libaio.x86_64 libaio-devel.i686 libaio-devel.x86_64 \
  libgcc.i686 libgcc.x86_64 libstdc++.i686 libstdc++.x86_64 libstdc++-devel.i686 libstdc++-devel.x86_64 libXi.i686 libXi.x86_64 \
  libXtst.i686 libXtst.x86_64 make.x86_64 sysstat.x86_64
  EOH
end





