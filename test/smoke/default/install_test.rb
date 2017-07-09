# # encoding: utf-8

# Inspec test for recipe mongodb::install

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe package 'mongodb-org' do
  it { should be_installed }
end

describe service 'mongod' do
  it { should be_enabled }
  it { should be_running }
end

describe port(27017) do
  it { should be_listening }
end
