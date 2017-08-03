#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
apt_update 'daily' do
  frequency 86_400
  action :periodic
end

#include_recipe 'mongodb::install'
include_recipe 'mongodb::replicaset_member'
#include_recipe 'mongodb::create_users'