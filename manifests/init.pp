# == Class: kong: See README.md for documentation.
class kong (
  $admin_api_listen_address            = $kong::params::admin_api_listen_address,
  $admin_api_listen_port               = $kong::params::admin_api_listen_port,
  $base_url                            = $kong::params::base_url,
  $cassandra_contact_points            = $kong::params::cassandra_contact_points,
  $cassandra_keyspace                  = $kong::params::database_name,
  $cassandra_replication_strategy      = $kong::params::cassandra_replication_strategy,
  $cassandra_replication_factor        = $kong::params::cassandra_replication_factor,
  $cassandra_data_centers              = $kong::params::cassandra_data_centers,
  $cassandra_ssl_enabled               = $kong::params::cassandra_ssl_enabled,
  $cassandra_ssl_verify                = $kong::params::cassandra_ssl_verify,
  $cassandra_ssl_certificate_authority = $kong::params::cassandra_ssl_certificate_authority,
  $cassandra_user                      = $kong::params::database_user,
  $cassandra_password                  = $kong::params::database_password,
  $cassandra_timeout                   = $kong::params::cassandra_timeout,
  $postgres_host                       = $kong::params::postgres_host,
  $postgres_port                       = $kong::params::postgres_port,
  $postgres_database                   = $kong::params::database_name,
  $postgres_user                       = $kong::params::database_user,
  $postgres_password                   = $kong::params::database_password,
  $cluster_advertise                   = $kong::params::cluster_advertise,
  $cluster_encrypt                     = $kong::params::cluster_encrypt,
  $cluster_listen_address              = $kong::params::cluster_listen_address,
  $cluster_listen_port                 = $kong::params::cluster_listen_port,
  $cluster_listen_rpc_address          = $kong::params::cluster_listen_rpc_address,
  $cluster_listen_rpc_port             = $kong::params::cluster_listen_rpc_port,
  $config_file_group                   = $kong::params::config_file_group,
  $config_file_mode                    = $kong::params::config_file_mode,
  $config_file_owner                   = $kong::params::config_file_owner,
  $config_file_path                    = $kong::params::config_file_path,
  $config_file_template                = $kong::params::config_file_template,
  $custom_plugins                      = $kong::params::custom_plugins,
  $database                            = $kong::params::database,
  $dns_resolver                        = $kong::params::dns_resolver,
  $kong_path                           = $kong::params::kong_path,
  $manage_package_dependencies         = $kong::params::manage_package_dependencies,
  $manage_package_fetch                = $kong::params::manage_package_fetch,
  $manage_init_file                    = $kong::params::manage_init_file,
  $memory_cache_size                   = $kong::params::memory_cache_size,
  $nginx_working_dir                   = $kong::params::nginx_working_dir,
  $package_dependencies                = $kong::params::package_dependencies,
  $package_manage                      = $kong::params::package_manage,
  $package_suffix                      = $kong::params::package_suffix,
  $proxy_listen_address                = $kong::params::proxy_listen_address,
  $proxy_listen_port                   = $kong::params::proxy_listen_port,
  $proxy_listen_ssl_address            = $kong::params::proxy_listen_ssl_address,
  $proxy_listen_ssl_port               = $kong::params::proxy_listen_ssl_port,
  $send_anonymous_reports              = $kong::params::send_anonymous_reports,
  $service_enable                      = $kong::params::service_enable,
  $service_ensure                      = $kong::params::service_ensure,
  $service_manage                      = $kong::params::service_manage,
  $ssl_cert_path                       = $kong::params::ssl_cert_path,
  $ssl_key_path                        = $kong::params::ssl_key_path,
  $systemd_init_file_template          = $kong::params::systemd_init_file_template,
  $sysv_init_file_template             = $kong::params::sysv_init_file_template,
  $upstart_init_file_template          = $kong::params::upstart_init_file_template,
  $use_staging                         = $kong::params::use_staging,
  $version                             = $kong::params::version,
  $download_url                        = "${base_url}/${package_suffix}?version=${version}"
) inherits kong::params {

  validate_absolute_path($config_file_path)
  if !is_ip_address($admin_api_listen_address) {
    fail("${module_name}: admin_api_listen_address value ${admin_api_listen_address} is not an address.")
  }
  validate_integer($admin_api_listen_port)
  validate_array($cassandra_contact_points)
  validate_string($cassandra_keyspace)
  validate_string($cassandra_replication_strategy)
  validate_bool($cassandra_ssl_enabled)
  validate_bool($cassandra_ssl_verify)
  validate_integer($cassandra_timeout)
  if !is_ip_address($cluster_listen_address) {
    fail("${module_name}: cluster_listen_address value ${cluster_listen_address} is not an address.")
  }
  validate_integer($cluster_listen_port)
  if !is_ip_address($cluster_listen_rpc_address) {
    fail("${module_name}: cluster_listen_rpc_address value ${cluster_listen_rpc_address} is not an address.")
  }
  validate_integer($cluster_listen_rpc_port)
  validate_absolute_path($config_file_path)
  validate_array($custom_plugins)
  validate_string($database)
  if ! ($database in [ 'cassandra', 'postgres' ]) {
    fail('database must be cassandra or postgres')
  }
  validate_string($dns_resolver)
  validate_absolute_path($kong_path)
  validate_bool($manage_init_file)
  validate_bool($manage_package_dependencies)
  validate_bool($manage_package_fetch)
  validate_integer($memory_cache_size)
  validate_absolute_path($nginx_working_dir)
  validate_bool($package_manage)
  validate_ip_address($proxy_listen_address)
  validate_integer($proxy_listen_port)
  validate_ip_address($proxy_listen_ssl_address)
  validate_integer($proxy_listen_ssl_port)
  validate_bool($send_anonymous_reports)
  validate_bool($service_enable)
  validate_bool($service_manage)
  validate_bool($use_staging)
  # FIXME validate_re version must be a version number or absent

  contain ::kong::install
  contain ::kong::config
  contain ::kong::initscripts
  contain ::kong::service

  Class['kong::install'] ->
  Class['kong::config'] ->
  Class['kong::initscripts']

  Class['kong::config'] ~>
  Class['kong::service']

  Class['kong::initscripts'] ~>
  Class['kong::service']
}
