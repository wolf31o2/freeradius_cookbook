# freeradius cookbook

# Requirements

* Ubuntu 12.04 or CentOS 6.5
* Chef 11.4+

# Usage

This cookbook sets up the FreeRADIUS server. Currently, it has only been used to get FreeRADIUS to authenticate using an OpenLDAP backend. It is planned to integrate support for SQL from [ngmaloney/chef-freeradius](https://github.com/ngmaloney/chef-freeradius).

# Attributes

## default recipe

* freeradius['use_ldap'] - Use LDAP backend. Default 'false'
* freeradius['local_secret'] - Local shared secret. Default 'testing123'
* freeradius['remote_clients'] - Array of remote clients, specified as IP address or CIDR notation. Default empty
* freeradius['remote_secret'] - Remote shared secret. Default 'insecure123' **WARNING: this is not very secure**

These attributes are automatically configured properly on Ubuntu and CentOS.

* freeradius['conf_dir'] - FreeRADIUS configuration directory.
* freeradius['group'] - Group to own files.
* freeradius['service'] - Name of the FreeRADIUS service.

## ldap

These are set to the FreeRADIUS shipped defaults on CentOS. You will need to change them to match your environment.

* freeradius['ldap']['server'] - Hostname LDAP server to contact.
* freeradius['ldap']['basedn'] - Base DN to search.
* freeradius['ldap']['filter'] - LDAP filter to match against.
* freeradius['ldap']['password_attribute'] - Password LDAP attribute. This defaults to OpenLDAP's attribute.

# Recipes

* `default` - Installs `freeradius` package and configures `clients.conf`
* `ldap` - Installs and configures LDAP backend support files

# License

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this software except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
