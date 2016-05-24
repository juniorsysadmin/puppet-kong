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
  manage_package_fetching => false,
}
```

### Parameters

#### `admin_api_listen_address`

Defaults to ```0.0.0.0```

#### `admin_api_listen_port`

Defaults to ```8001```

#### `base_url`

Defaults to ```https://downloadkong.org```

#### `cassandra_contact_points`

Defaults to ```[ '127.0.0.1:9042' ]```

#### `cassandra_keyspace`

Defaults to ```kong```

#### `cassandra_replication_strategy`

Defaults to ```SimpleStrategy```

#### `cassandra_replication_factor`

Used only when the replication strategy is set to ```SimpleStrategy```.
Defaults to ```1```

#### `cassandra_data_centers`

Used only when the replication strategy is set to ```NetworkTopologyStrategy```.

#### `cassandra_ssl_enabled`

Defaults to ```false```

#### `cassandra_ssl_verify`

Defaults to ```false```

#### `cassandra_ssl_certificate_authority`

Absolute path to the trusted CA certificate in PEM format when ```cassandra_ssl_verify```
is set to ```true```

#### `cassandra_user`

Optional

#### `cassandra_password`

Optional

#### `cassandra_timeout`

Defaults to 5000

#### `postgres_host`

Defaults to ```127.0.0.1```

#### `postgres_port`

Defaults to ```5432```

#### `postgres_database`

Defaults tp ```kong```

#### `postgres_user`

Optional

#### `postgres_password`

Optional

#### `cluster_advertise`

Optional

#### `cluster_encrypt`

Optional

#### `cluster_listen_address`

Defaults to ```0.0.0.0```

#### `cluster_listen_port`

Defaults to ```7946```

#### `cluster_listen_rpc_address`

Defaults to ```127.0.0.1```

#### `cluster_listen_rpc_port`

Defaults to ```7373```

#### `config_file_group`

Defaults to ```root```

#### `config_file_mode`

Defaults to ```0644```

#### `config_file_owner`

Defaults to ```root```

#### `config_file_path`

Defaults to ```/etc/kong/kong.yml```

#### `custom_plugins`

Defaults to all plugins

#### `database`

Which database to use. Options are ```cassandra``` or ```postgres```.
Note that the database is not managed by this module.
Defaults to ```cassandra```.

#### `dns_resolver`

Defaults to ```dnsmasq```

#### `kong_path`

Defaults to ```/usr/local/bin/kong```

#### `manage_package_dependencies`

Defaults to ```true```

#### `manage_package_fetch`

Defaults to ```true```

#### `manage_init_file`

Defaults to ```true```

#### `memory_cache_size`

Defaults to ```128```

#### `nginx_working_dir`

Defaults to ```/usr/local/kong/```

#### `package_manage`

Defaults to ```true```

#### `proxy_listen_address`

Defaults to ```0.0.0.0```

#### `proxy_listen_port`

Defaults to ```8000```

#### `proxy_listen_ssl_address`

Defaults to ```0.0.0.0```

#### `proxy_listen_ssl_port`

Defaults to ```8443```

#### `send_anonymous_reports`

Defaults to ```true```

#### `service_enable`

Defaults to ```true```

#### `service_ensure`

Defaults to ```running```

#### `service_manage`

Defaults to ```true```

#### `ssl_cert_path`

Optional

#### `ssl_key_path`

Optional

#### `use_staging`

Use the ```puppet/staging``` module for fetching the package rather than ```puppet/archive```.
Defaults to ```false```

### `version`

Defaults to 0.8.1

## Limitations

This module has received limited testing on:

* CentOS/RHEL 5/6/7
* Debian 6/7/8
* Ubuntu 12.04/14.04/15.04

The following platforms should also work, but have not been tested:

* Amazon Linux
* Archlinux
* Darwin

### Module dependencies

If using CentoOS/RHEL 5/6/7, you will need to ensure that the `stahnma-epel`
module is installed.

## Development

Patches are welcome.