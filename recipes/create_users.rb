#
# Cookbook:: chef-mongodb-recipe
# Recipe:: create_users
#
# Copyright:: 2017, The Authors, All Rights Reserved.
mongo_gem 'mongo_gem'

passwords = data_bag_item('passwords', 'admin')

mongo_user node['mongod']['config']['admin_username'] do
  database node['mongod']['config']['admin_database']
  pwd passwords['admin_password']
  roles node['mongod']['config']['admin_role']
  action :create
  not_if { ::File.exists?("/etc/chef/stamps/#{node['mongod']['config']['admin_username']}.stamp") }
end

file "/etc/chef/stamps/#{node['mongod']['config']['admin_username']}.stamp" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end