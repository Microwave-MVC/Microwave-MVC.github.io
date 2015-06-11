require 'serverspec'

USER = "vagrant"
PATH = "/opt/rbenv/bin:/opt/rbenv/shims:$PATH";
MICROWAVE_HOME = "/home/vagrant/microwave-workspace"

# Required by serverspec
set :backend, :exec
set :path, PATH

RSpec.configure do |c|
  user    = USER
end

# Ruby 2.2.2
describe package('ruby') do
  it { should be_installed}
end

describe command('ruby -v') do
  its(:stdout) { should match '2.2.2' }
end

# Bundle
describe command('which bundle') do
  its(:stdout) { should match '/opt/rbenv/shims/bundle' }
end

describe command('cd #{MICROWAVE_HOME} && bundle install') do
  its(:exit_status) { should eq 0 }
end

# Postgresql
# describe service('postgresql') do
#   it { should be_running }
# end

# describe command('cd #{MICROWAVE_HOME} && bundle exec rake db:create db:migrate') do
#   its(:exit_status) { should eq 0 }
# end

# Node.js (required by Rails 3 asset pipeline)
describe package('nodejs') do
  it { should be_installed }
end

