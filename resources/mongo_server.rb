# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :mongo_server 
property :mongo_server, String, name_property: true
property :config_file, String
property :db_path, String
property :keyfile, String

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

    if property_is_set?(:db_path)
        directory new_resource.db_path do
            owner 'mongodb'
            group 'mongodb'
            mode '0755'
            recursive true
            action :create
        end
    end

    if property_is_set?(:config_file)
        template '/etc/mongod.conf' do
            source 'mongod.conf.erb'
            owner 'mongodb'
            group 'mongodb'
            mode '0755'
            action :create
        end
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
