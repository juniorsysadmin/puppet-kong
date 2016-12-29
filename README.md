# puppet-kong module

[![Build Status](https://travis-ci.org/juniorsysadmin/puppet-kong.svg?branch=master)](https://travis-ci.org/juniorsysadmin/puppet-kong)

#### Table of Contents

1. [Overview](#overview)
1. [Setup - The basics of getting started with kong](#setup)
    * [Beginning with kong - Installation](#beginning-with-kong)
1. [Usage](#usage)
1. [Parameters](#parameters)
1. [Limitations - OS compatibility, etc.](#limitations)
    * [Module dependencies](#module-dependencies)
1. [Development](#development)

## Overview

The puppet-kong module installs the Kong package, manages the Kong admin
configuration and manages the Kong service.

By default this module installs packages from the [Kong](https://getkong.org)
website, with all package dependencies.

## Setup

### What puppet-kong affects:

* the Kong package
* the Kong admin configuration (/etc/kong/kong.yml)
* the Kong service

### Beginning with puppet-kong

To install Kong:

```puppet
class { 'kong': }
```

## Usage

If you do not want package dependencies installed by this module:

```puppet
class { 'kong':
  manage_package_dependencies => false,
}
```

If you do not want package fetching to be handled by this module:

```puppet
class { 'kong':
  manage_package_fetch => false,
}
```

## Versioning

With the default setting of ```manage_package_fetch``` set to ```true```, the
```version``` parameter determines what package version will attempt to be
installed, after fetching it.

The native package providers that Puppet defaults
to using (apt, yum) do not support package installation from a package in a
local directory. Package providers dpkg and rpm do, but they do not support
the versionable package attribute.

As a consequence, this module currently only supports new Kong installations
or package upgrades when ```manage_package_fetch``` is set to ```true``` (Only
new installations are supported on OSX, not upgrades).

If the ability to downgrade the package version is important to you, simply
include the Kong package in your own local repository, and set the
```manage_package_fetch``` parameter to ```false``` - this will result in the
native package provider being used during installation and Puppet doing the
right thing based on the ```version``` parameter.

### Parameters

#### `admin_listen`

Defaults to ```0.0.0.0:8001```

#### `anonymous_reports`

Defaults to ```true```

#### `base_url`

Defaults to ```https://downloadkong.org```

#### `cassandra_consistency`

Defaults to ```ONE```

#### `cassandra_contact_points`

Defaults to single contact point ```[ '127.0.0.1' ]```

#### `cassandra_data_centers`

Used only when the replication strategy is set to ```NetworkTopologyStrategy```.
Variable type: Array

#### `cassandra_keyspace`

Defaults to ```kong```

#### `cassandra_password`

Optional

#### `cassandra_port`

Defaults to 9042

#### `cassandra_repl_factor`

Used only when the replication strategy is set to ```SimpleStrategy```.
Defaults to ```1```

#### `cassandra_repl_strategy`

Defaults to ```SimpleStrategy```

#### `cassandra_ssl`

Defaults to ```false```

#### `cassandra_ssl_verify`

Defaults to ```false```

#### `cassandra_timeout`

Connection and reading timeout (in ms). Defaults to 5000.

#### `cassandra_username`

Optional

#### `cluster_advertise`

Optional address:port used by the node to communicate with other Kong
nodes in the cluster.

#### `cluster_encrypt_key`

Optional key for encrypting network traffic within Kong.

#### `cluster_listen`

Defaults to ```0.0.0.0:7946```

#### `cluster_listen_rpc`

Defaults to ```127.0.0.1:7373```

#### `cluster_profile`

Defaults to ```wan```

#### `cluster_ttl_on_failure`

Defaults to ```3600```

#### `config_file_group`

Defaults to ```0```

#### `config_file_mode`

Defaults to ```0644```

#### `config_file_owner`

Defaults to ```root```

#### `config_file_path`

Defaults to ```/etc/kong.conf```

#### `custom_plugins`

An array of additional plugins that Kong needs to load.

#### `database`

Which database to use. Options are ```cassandra``` or ```postgres```
Defaults to ```cassandra```. Note that the database is not managed by this
module.

#### `dnsmasq`

Defaults to ```true```

#### `dnsmasq_port`

Defaults to ```8053```

#### `dns_resolver`

Used if `dnsmasq` is set to ```false```. Default value is ```8.8.8.8```

#### `dns_resolvers_available`

A hash of DNS resolvers Kong can use. Defaults to dnsmasq, port 8053.

#### `kong_path`

Defaults to ```/usr/local/bin/kong```

#### `kong_prefix`

Defaults to ```/usr/local/kong/```

#### `log_level`

Defaults to ```notice```

#### `lua_ssl_trusted_certificate`

Absolute path to the trusted CA certificate in PEM format when ```cassandra_ssl_verify```
or ```pg_ssl_verify``` is set to ```true```

#### `manage_init_file`

Defaults to ```true```

#### `manage_package_dependencies`

Defaults to ```true```

#### `manage_package_fetch`

Defaults to ```true```

#### `mem_cache_size`

Defaults to ```128m```

#### `nginx_conf`

A nginx configuration template that is compiled using the Penlight templating
engine, and then used by Kong.

#### `nginx_daemon`

Defaults to ```true```

#### `nginx_worker_processes`

Defaults to ```auto```

#### `package_manage`

Defaults to ```true```

#### `package_provider`

When ```manage_package_fetch``` is set to true, this value is used to
determine the package manager used to install the downloaded package.

#### `pg_database`

Defaults to ```kong```

#### `pg_host`

Defaults to ```127.0.0.1```

#### `pg_password`

No default. Required if ```database``` is set to ```postgres```

#### `pg_port`

Defaults to ```5432```

#### `pg_ssl`

Defaults to ```false```

#### `pg_ssl_verify`

Defaults to ```false```

#### `pg_user`

No default. Required if ```database``` is set to ```postgres```

#### `proxy_listen`

Defaults to ```0.0.0.0:8000```

#### `proxy_listen_ssl`

Defaults to ```0.0.0.0:8443```

#### `service_enable`

Defaults to ```true```

#### `service_ensure`

Defaults to ```running```

#### `service_manage`

Defaults to ```true```

#### `ssl`

Defaults to ```true```

#### `ssl_cert`

Optional path to the SSL certificate that Kong will use when listening on the
https port

#### `ssl_cert_key`

Optional path to the SSL certificate key that Kong will use when listening on
the https port

#### `staging_dir`

Directory where the downloaded packages are stored when ```manage_package_fetch```
is set to ```true```

#### `use_staging`

Use the ```puppet/staging``` module for fetching the package rather than ```puppet/archive```.
Defaults to ```false```

### `version`

Determines the package version to fetch if ```manage_package_fetch``` is set
to true. Otherwise, determines the version of Kong to install from the local
package repository. Defaults to 0.8.3

## Limitations

This module has received limited testing on:

* CentOS/RHEL 5/6/7
* Debian 6/7/8
* Ubuntu 12.04/14.04/15.04/16.04

The following platforms should also work, but have not been tested:

* Amazon Linux
* Archlinux
* Darwin

### Module dependencies

If using CentoOS/RHEL 5/6/7, you will need to ensure that the `stahnma-epel`
module is installed.

## Development

Patches are welcome.