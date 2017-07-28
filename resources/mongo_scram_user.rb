# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :mongo_scram_user
property :mongo_scram_user, String, name_property: true
property :database, String, required: true
property :pwd, String, required: true
property :roles, Array, required: true

action :create do
  execute 'create user' do
    command 'mongo '
    action :run
  end
  
end