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

service 'mongod' do
  action [:enable, :start]
end
