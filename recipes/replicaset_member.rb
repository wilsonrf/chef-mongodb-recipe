#
# Cookbook:: chef-mongodb-recipe
# Recipe:: replicaset_member
#
# Copyright:: 2017, The Authors, All Rights Reserved.
mongo_server 'mongo1' do
  port 37017
  action :create
end