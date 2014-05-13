#
# Cookbook Name:: freeradius
# Recipe:: default
#
# Copyright (C) 2013-2014 Continuuity, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Install packages
%w(freeradius freeradius-utils).each do |pkg|
  package pkg do
    action :install
  end
end

# Create conf_dir, modules, and sites-available
directory node['freeradius']['conf_dir'] do
  mode '0755'
  owner 'root'
  group node['freeradius']['group']
  action :create
  recursive true
end

directory "#{node['freeradius']['conf_dir']}/sites-available" do
  mode '0755'
  owner 'root'
  group node['freeradius']['group']
  action :create
end

directory "#{node['freeradius']['conf_dir']}/modules" do
  mode '0755'
  owner 'root'
  group node['freeradius']['group']
  action :create
end
# End directories

# Add default and inner-tunnel to sites-available
template "#{node['freeradius']['conf_dir']}/sites-available/default" do
  source 'sites-available/default.erb'
  mode '0640'
  owner 'root'
  group node['freeradius']['group']
  action :create
end

template "#{node['freeradius']['conf_dir']}/sites-available/inner-tunnel" do
  source 'sites-available/inner-tunnel.erb'
  mode '0640'
  owner 'root'
  group node['freeradius']['group']
  action :create
end

# Do we want LDAP?
include_recipe 'freeradius::ldap' if node['freeradius']['use_ldap']
