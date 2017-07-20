# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :mongo_gem
property :mongo_gem, String, name_property: true
property :gem_version, String, default: '2.4'

provides :mongo_gem

action :install do
  include_recipe 'build-essential::default'
  gem_package 'mongo' do
    gem_binary RbConfig::CONFIG['bindir'] + '/gem'
    version new_resource.gem_version
    action :install
  end
end