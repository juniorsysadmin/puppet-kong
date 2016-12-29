# == Class: kong: See README.md for documentation.
class kong (
  $admin_listen                        = $kong::params::admin_listen,
  $anonymous_reports                   = $kong::params::anonymous_reports,
  $base_url                            = $kong::params::base_url,
  $cassandra_consistency               = $kong::params::cassandra_consistency,
  $cassandra_contact_points            = $kong::params::cassandra_contact_points,
  $cassandra_data_centers              = $kong::params::cassandra_data_centers,
  $cassandra_keyspace                  = $kong::params::cassandra_keyspace,
  $cassandra_password                  = $kong::params::cassandra_password,
  $cassandra_replication_factor        = $kong::params::cassandra_replication_factor,
  $cassandra_replication_strategy      = $kong::params::cassandra_replication_strategy,
  $cassandra_ssl_certificate_authority = $kong::params::cassandra_ssl_certificate_authority,
  $cassandra_ssl_enabled               = $kong::params::cassandra_ssl_enabled,
  $cassandra_ssl_verify                = $kong::params::cassandra_ssl_verify,
  $cassandra_timeout                   = $kong::params::cassandra_timeout,
  $cassandra_user                      = $kong::params::cassandra_user,
  $cluster_advertise                   = $kong::params::cluster_advertise,
  $cluster_encrypt                     = $kong::params::cluster_encrypt,
  $cluster_listen                      = $kong::params::cluster_listen,
  $cluster_listen_rpc                  = $kong::params::cluster_listen_rpc,
  $cluster_ttl_on_failure              = $kong::params::cluster_ttl_on_failure,
  $config_file_group                   = $kong::params::config_file_group,
  $config_file_mode                    = $kong::params::config_file_mode,
  $config_file_owner                   = $kong::params::config_file_owner,
  $config_file_path                    = $kong::params::config_file_path,
  $config_file_template                = $kong::params::config_file_template,
  $custom_plugins                      = $kong::params::custom_plugins,
  $database                            = $kong::params::database,
  $dns_resolver                        = $kong::params::dns_resolver,
  $dns_resolvers_available             = $kong::params::dns_resolvers_available,
  $kong_path                           = $kong::params::kong_path,
  $kong_prefix                         = $kong::params::kong_prefix,
  $log_level                           = $kong::params::log_level,
  $manage_package_dependencies         = $kong::params::manage_package_dependencies,
  $manage_package_fetch                = $kong::params::manage_package_fetch,
  $manage_init_file                    = $kong::params::manage_init_file,
  $memory_cache_size                   = $kong::params::memory_cache_size,
  $nginx_conf                          = $kong::params::nginx_conf,
  $nginx_daemon                        = $kong::params::nginx_daemon,
  $nginx_worker_processes              = $kong::params::nginx_worker_processes,
  $package_dependencies                = $kong::params::package_dependencies,
  $package_manage                      = $kong::params::package_manage,
  $package_provider                    = $kong::params::package_provider,
  $package_suffix                      = $kong::params::package_suffix,
  $postgres_database                   = $kong::params::postgres_database,
  $postgres_host                       = $kong::params::postgres_host,
  $postgres_password                   = $kong::params::postgres_password,
  $postgres_port                       = $kong::params::postgres_port,
  $postgres_user                       = $kong::params::postgres_user,
  $proxy_listen                        = $kong::params::proxy_listen,
  $proxy_listen_ssl                    = $kong::params::proxy_listen_ssl,
  $service_enable                      = $kong::params::service_enable,
  $service_ensure                      = $kong::params::service_ensure,
  $service_manage                      = $kong::params::service_manage,
  $ssl_cert_path                       = $kong::params::ssl_cert_path,
  $ssl_key_path                        = $kong::params::ssl_key_path,
  $staging_dir                         = $kong::params::staging_dir,
  $systemd_init_file_template          = $kong::params::systemd_init_file_template,
  $sysv_init_file_template             = $kong::params::sysv_init_file_template,
  $upstart_init_file_template          = $kong::params::upstart_init_file_template,
  $use_staging                         = $kong::params::use_staging,
  $version                             = $kong::params::version,
  $download_url                        = "${base_url}/${package_suffix}?version=${version}"
) inherits kong::params {

  $_admin_api_listen_address = join(reverse(delete_at(reverse(split($admin_listen, ':')), 0)), ':')
  $_admin_api_listen_array   = split($admin_listen, ':')
  $_admin_api_listen_port    = $_admin_api_listen_array[-1]

  if ! is_ip_address($_admin_api_listen_address) {
    fail("${module_name}: ${admin_listen} does not contain a valid IP address.")
  }
  validate_integer($_admin_api_listen_port)
  validate_bool($anonymous_reports)
  validate_re($cassandra_consistency, '^(ALL|EACH_QUORUM|QUORUM|LOCAL_QUORUM|ONE|TWO|THREE|LOCAL_ONE|ANY)$')
  validate_array($cassandra_contact_points)
  validate_array($cassandra_data_centers)
  validate_string($cassandra_keyspace)
  validate_integer($cassandra_replication_factor)
  validate_re($cassandra_replication_strategy, '^(SimpleStrategy|NetworkTopologyStrategy)$')

  if $cassandra_ssl_certificate_authority {
    validate_absolute_path($cassandra_ssl_certificate_authority)
  }

  validate_bool($cassandra_ssl_enabled)
  validate_bool($cassandra_ssl_verify)
  validate_integer($cassandra_timeout)

  if $cluster_advertise {
    $_cluster_advertise_address = join(reverse(delete_at(reverse(split($cluster_advertise, ':')), 0)), ':')
    $_cluster_advertise_array   = split($cluster_advertise, ':')
    $_cluster_advertise_port    = $_cluster_advertise_array[-1]

    if ! is_ip_address($_cluster_advertise_address) {
      fail("${module_name}: ${cluster_advertise} does not contain a valid IP address.")
    }
    validate_integer($_cluster_advertise_port)
  }

  $_cluster_listen_address = join(reverse(delete_at(reverse(split($cluster_listen, ':')), 0)), ':')
  $_cluster_listen_array   = split($cluster_listen, ':')
  $_cluster_listen_port    = $_cluster_listen_array[-1]

  if ! is_ipv4_address($_cluster_listen_address) {
    fail("${module_name}: ${cluster_listen} does not contain a valid IPv4 address.")
  }
  validate_integer($_cluster_listen_port)

  $_cluster_listen_rpc_address = join(reverse(delete_at(reverse(split($cluster_listen_rpc, ':')), 0)), ':')
  $_cluster_listen_rpc_array   = split($cluster_listen_rpc, ':')
  $_cluster_listen_rpc_port    = $_cluster_listen_rpc_array[-1]

  if ! is_ipv4_address($_cluster_listen_rpc_address) {
    fail("${module_name}: ${cluster_listen_rpc} does not contain a valid IPv4 address.")
  }
  validate_integer($_cluster_listen_rpc_port)

  if $cluster_ttl_on_failure {
    validate_integer($cluster_ttl_on_failure)
  }

  validate_array($custom_plugins)
  validate_re($database, '^(cassandra|postgres)$', "${module_name}: Database must be cassandra or postgres.")
  validate_string($dns_resolver)
  validate_hash($dns_resolvers_available)
  validate_absolute_path($kong_path)
  validate_absolute_path($kong_prefix)
  validate_string($log_level)
  validate_bool($manage_init_file)
  validate_bool($manage_package_dependencies)
  validate_bool($manage_package_fetch)
  validate_integer($memory_cache_size)
  validate_bool($nginx_daemon)
  validate_array($package_dependencies)
  validate_bool($package_manage)
  validate_integer($postgres_port)

  $_proxy_listen_address = join(reverse(delete_at(reverse(split($proxy_listen, ':')), 0)), ':')
  $_proxy_listen_array   = split($proxy_listen, ':')
  $_proxy_listen_port    = $_proxy_listen_array[-1]

  if ! is_ipv4_address($_proxy_listen_address) {
    fail("${module_name}: ${proxy_listen} does not contain a valid IPv4 address.")
  }
  validate_integer($_proxy_listen_port)

  $_proxy_listen_ssl_address = join(reverse(delete_at(reverse(split($proxy_listen_ssl, ':')), 0)), ':')
  $_proxy_listen_ssl_array   = split($proxy_listen_ssl, ':')
  $_proxy_listen_ssl_port    = $_proxy_listen_ssl_array[-1]

  if ! is_ip_address($_proxy_listen_ssl_address) {
    fail("${module_name}: ${proxy_listen_ssl} does not contain a valid IPv4 address.")
  }

  validate_integer($_proxy_listen_ssl_port)
  validate_bool($service_enable)
  validate_bool($service_manage)

  if $ssl_cert_path {
    validate_absolute_path($ssl_cert_path)
  }

  if $ssl_key_path {
    validate_absolute_path($ssl_key_path)
  }

  if $nginx_conf {
    validate_absolute_path($nginx_conf)
  }

  validate_bool($use_staging)

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
