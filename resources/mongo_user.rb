# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :mongo_user
property :mongo_user, String, name_property: true
property :database, String, required: true
property :pwd, String, required: true
property :roles, Array, required: true

action :create do
  require 'mongo'
  client = Mongo::Client.new(['localhost:27017'], database: new_resource.database)
  client.database.users.create(new_resource.mongo_user, password: new_resource.pwd, roles: new_resource.roles)
  client.close
end