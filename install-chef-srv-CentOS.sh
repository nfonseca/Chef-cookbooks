#!/bin/bash

# create staging directories
if [ ! -d /drop ]; then
  mkdir /drop
fi
if [ ! -d /downloads ]; then
  mkdir /downloads
fi

# download the Chef server package
if [ ! -f /downloads/chef-server-core-12.17.33-1.el7.x86_64.rpm ]; then
  echo "Downloading the Chef server package..."
  wget -nv -P /downloads https://packages.chef.io/files/stable/chef-server/12.17.33/el/7/chef-server-core-12.17.33-1.el7.x86_64.rpm

fi

# install Chef server
if [ ! $(which chef-server-ctl) ]; then
  echo "Installing Chef server..."
  rpm -ivh /downloads/chef-server-core-12.17.33-1.el7.x86_64.rpm
  chef-server-ctl reconfigure

  echo "Waiting for services..."
  until (curl -D - http://localhost:8000/_status) | grep "200 OK"; do sleep 15s; done
  while (curl http://localhost:8000/_status) | grep "fail"; do sleep 15s; done

  echo "Creating initial user and organization..."
  chef-server-ctl user-create chefadmin Chef Admin admin@vxrail.com insecurepassword --filename /drop/chefadmin.pem
  chef-server-ctl org-create vxrail "VxRail" --association_user chefadmin --filename vxrail-validator.pem
fi

firewall-cmd --permanent --zone public --add-service http
firewall-cmd --permanent --zone public --add-service https
firewall-cmd --reload

echo "Your Chef server is ready!"
