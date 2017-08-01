#
# Cookbook:: mongodb
# Recipe:: install
#
# Copyright:: 2017, The Authors, All Rights Reserved.
apt_repository 'mongodb_xenial' do
  uri 'http://repo.mongodb.org/apt/ubuntu'
  keyserver 'hkp://keyserver.ubuntu.com:80'
  distribution 'xenial/mongodb-org/3.4'
  components ['multiverse']
  arch 'amd64'
  key '0C49F3730359A14518585931BC711F9BA15703C6'
  action :add
end

apt_update 'update' do
  action :update
end

apt_package 'mongodb-org' do
  action :install
end

directory node['mongod']['config']['db_path'] do
  owner 'mongodb'
  group 'mongodb'
  mode '0755'
  recursive true
  action :create
end

directory node['mongod']['config']['etc_path'] do
  owner 'mongodb'
  group 'mongodb'
  mode '0755'
  recursive true
  action :create
end

cookbook_file '/etc/mongodb/keyfile' do
  source 'keyfile'
  owner 'mongodb'
  group 'mongodb'
  mode '0400'
  action :create
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner 'mongodb'
  group 'mongodb'
  mode '0755'
  action :create
end

service 'mongod' do
  action [:enable, :start]
end

directory '/etc/chef/stamps' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end
