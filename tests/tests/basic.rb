control 'opensips-repository-file' do
  impact 1.0
  title 'opensips repository files'
  desc 'The required opensips and yours modules should be installed.'

  [
    '/etc/apt/sources.list.d/opensips.list',
    '/etc/apt/sources.list.d/opensips-cli.list',
  ].each do |item|
    describe file(item) do
      it { should exist }
      it { should be_file }
    end
  end
end

control 'opensips-and-modules' do
  impact 1.0
  title 'opensips and modules'
  desc 'The opensips repository files are created.'

  [
    'opensips',
    'opensips-cli',
    'opensips-postgres-module',
    'opensips-xmlrpc-module'
  ].each do |item|
    describe package(item) do
      it { should be_installed }
    end
  end
end

control 'opensips-daemon-settings' do
  impact 1.0
  title 'opensips daemon settings'
  desc 'The opensips daemon settings are correct.'

  describe file('/etc/default/opensips') do
    it { should exist }
    it { should be_file }
    its('group') { should eq 'opensips' }
    its('owner') { should eq 'opensips' }
    its('md5sum') { should eq '39147d66b382257b4464111bc8ad4ae5' }
  end
end

control 'opensips-daemon-user' do
  impact 1.0
  title 'opensips daemon user'
  desc 'The opensips daemon create a correct users.'

  describe group('opensips') do
    it { should exist }
  end

  describe user('opensips') do
    it { should exist }
    its('group') { should eq 'opensips' }
    its('shell') { should eq '/bin/false' }
  end
end



control 'opensips-service' do
  impact 1.0
  title 'opensips service behavior'
  desc 'Validate opensips service behavior.'

  describe service('opensips') do
    it { should be_enabled }
    it { should be_running }
  end
end
