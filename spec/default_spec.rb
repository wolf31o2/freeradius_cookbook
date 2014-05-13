require 'spec_helper'

describe 'freeradius::default' do
  context 'on Centos 6.4 x86_64' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'centos', version: 6.4) do |node|
        node.automatic['domain'] = 'example.com'
      end.converge(described_recipe)
    end

    %w(freeradius freeradius-utils).each do |pkg|
      it "installs #{pkg} package" do
        expect(chef_run).to install_package(pkg)
      end
    end

    %w(/etc/raddb /etc/raddb/modules /etc/raddb/sites-available).each do |dir|
      it "creates #{dir} directory" do
        expect(chef_run).to create_directory(dir)
      end
    end
  end

  context 'on Ubuntu 12.04 with use_ldap' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'ubuntu', version: 12.04) do |node|
        node.automatic['domain'] = 'example.com'
        node.override['freeradius']['use_ldap'] = true
      end.converge(described_recipe)
    end

    %w(/etc/freeradius /etc/freeradius/modules /etc/freeradius/sites-available).each do |dir|
      it "creates #{dir} directory" do
        expect(chef_run).to create_directory(dir)
      end
    end
  end
end
