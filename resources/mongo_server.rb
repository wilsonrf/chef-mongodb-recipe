# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :mongo_server
property :mongo_server, String, name_property: true
property :db_path, String
property :port, Integer
property :keyfile, String
property :is_replicaset, default: false

action :create do
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

  if property_is_set?(:port)
    node.default['mongod']['config']['port'] = new_resource.port
  end
  if property_is_set?(:db_path)
    node.default['mongod']['config']['db_path'] = new_resource.db_path
  end

  directory node['mongod']['config']['db_path'] do
    owner 'mongodb'
    group 'mongodb'
    mode '0755'
    recursive true
    action :create
  end

  template node['mongod']['config']['file'] do
    source 'mongod.conf.erb'
    owner 'mongodb'
    group 'mongodb'
    mode '0755'
    variables({
        authorization: node['mongod']['config']['authorization_enabled'],
        port: node['mongod']['config']['port'],
        is_replica: new_resource.is_replicaset,
        db_path: node['mongod']['config']['db_path'],
        log_path: node['mongod']['config']['log_path']
    })
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
end
