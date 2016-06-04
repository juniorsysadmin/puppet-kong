## Future

### Summary

This release provides several bugfixes, bumps the default version to 0.8.2 and
adds new parameters for the 0.8.x version of Kong.

#### Features

- Applies modulesync changes (from Voxpupuli modulesync_configs).
- Changes default version to 0.8.3.
- Adds new configuration parameters for 0.8.x.
- Splits off the nginx.conf contents into a new variable.
- Cleans up the kong.yml template, double quoting variables and removes
  (most) commented sections taken from the default upstream file.
- Adds better documentation for parameters.
- Changes validation of certain IP addresses to IPv4 only.
- Adds validation of the database type.
- Adds ```dns_resolvers_available``` parameter.
- Replaces ```proxy_listen_address``` and ```proxy_listen_port``` parameters
  with ```proxy_listen```.
- Replaces ```proxy_listen_ssl_address``` and ```proxy_listen_ssl_port```
  parameters with ```proxy_listen_ssl```.
- Replaces ```admin_api_listen_address``` and ```admin_api_listen_port```
  parameters with ```admin_api_listen```.
- Replaces ```cluster_listen_address``` and ```cluster_listen_port```
  parameters with ```cluster_listen```.
- Replaces ```cluster_listen_rpc_address``` and ```cluster_listen_rpc_port```
  parameters with ```cluster_listen_rpc```.
- Changes ```config_file_group``` to 0 rather than root in preparation for
  FreeBSD support.
- Adds better validation of parameters.
- Adds ```staging_dir``` parameter.

#### Bugfixes

- Fixes ```custom_plugins``` to be empty since supported plugins are loaded
  by default.
- Fixes printing of ```cassandra_ssl_*``` values.
- Fixes metadata.json formatting.
- Fixes variable quoting in initscripts.pp.
- Fixes the Upstart script to include ```start```.
- Fixes inconsistent Puppet-managed template headers.
- Fixes installation issues due to the native package provider not supporting
  the source package attribute.
- Attempts to fix up non-working OSX installation.

## 2016-04-12 Release 0.0.1

- Initial module release.
