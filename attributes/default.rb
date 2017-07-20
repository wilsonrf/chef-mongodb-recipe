default['mongod']['config']['file'] = '/etc/mongod.conf'
default['mongod']['config']['authorization_enabled'] = 'enabled'
default['mongod']['config']['bind_ip'] = '127.0.0.1'
default['mongod']['config']['port'] = '27017'
default['mongod']['config']['db_path'] = '/data/db'
default['mongod']['config']['log_path'] = '/var/log/mongodb/mongod.log'
default['mongod']['config']['rel_set_name'] = 'replicaSet0'
default['mongod']['config']['admin_username'] = 'admin'
default['mongod']['config']['admin_database'] = 'admin'
default['mongod']['config']['admin_role'] = ['userAdminAnyDatabase']