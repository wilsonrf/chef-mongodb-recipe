# # encoding: utf-8

# Inspec test for recipe chef-mongodb-recipe::create_users

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe file '/etc/chef/stamps/admin.stamp' do
  it { should exist }
end
