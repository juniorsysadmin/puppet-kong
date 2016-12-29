class kong::params {
  $admin_listen                        = '0.0.0.0:8001'
  $anonymous_reports                   = true
  $base_url                            = 'https://downloadkong.org'
  $cassandra_consistency               = 'ONE'
  $cassandra_contact_points            = [ '127.0.0.1:9042' ]
  $cassandra_data_centers              = []
  $cassandra_keyspace                  = 'kong'
  $cassandra_password                  = undef
  $cassandra_replication_factor        = 1
  $cassandra_replication_strategy      = 'SimpleStrategy'
  $cassandra_ssl_certificate_authority = undef
  $cassandra_ssl_enabled               = false
  $cassandra_ssl_verify                = false
  $cassandra_timeout                   = 5000
  $cassandra_user                      = undef
  $cluster_advertise                   = undef
  $cluster_encrypt                     = undef
  $cluster_listen                      = '0.0.0.0:7946'
  $cluster_listen_rpc                  = '127.0.0.1:7373'
  $cluster_ttl_on_failure              = undef
  $config_file_group                   = '0'
  $config_file_mode                    = '0644'
  $config_file_owner                   = 'root'
  $config_file_path                    = '/etc/kong.conf'
  $config_file_template                = 'kong/kong.yml.erb'
  $custom_plugins                      = []
  $database                            = 'cassandra'
  $dns_resolver                        = 'dnsmasq'
  $dns_resolvers_available             = { dnsmasq => { port => 8053 }, }
  $kong_path                           = '/usr/local/bin/kong'
  $kong_prefix                         = '/usr/local/kong/'
  $log_level                           = 'notice'
  $manage_init_file                    = true
  $manage_package_dependencies         = true
  $manage_package_fetch                = true
  $memory_cache_size                   = 128
  $nginx_conf                          = undef
  $nginx_worker_processes              = 'auto'
  $package_manage                      = true
  $postgres_database                   = 'kong'
  $postgres_host                       = '127.0.0.1'
  $postgres_password                   = undef
  $postgres_port                       = 5432
  $postgres_user                       = undef
  $proxy_listen                        = '0.0.0.0:8000'
  $proxy_listen_ssl                    = '0.0.0.0:8443'
  $service_enable                      = true
  $service_ensure                      = 'running'
  $service_manage                      = true
  $ssl_cert_path                       = undef
  $ssl_key_path                        = undef
  $staging_dir                         = '/opt'
  $systemd_init_file_template          = 'kong/init/systemd/kong.service.erb'
  $sysv_init_file_template             = 'kong/init/sysv/kong.erb'
  $upstart_init_file_template          = 'kong/init/upstart/kong.conf.erb'
  $use_staging                         = false
  $version                             = '0.8.3'

  case $::osfamily {
    'Debian': {
      $package_dependencies = ['netcat', 'openssl', 'libpcre3', 'dnsmasq', 'procps', 'perl']
      $package_provider     = 'dpkg'
      $systemd_unit_path    = '/lib/systemd/system'
      case $::operatingsystemmajrelease {
        '6': {
          $package_suffix = 'squeeze_all.deb'
        }
        '7': {
          $package_suffix = 'wheezy_all.deb'
        }
        '8': {
          $package_suffix = 'jessie_all.deb'
        }
        '12.04': {
          $package_suffix = 'precise_all.deb'
        }
        '14.04': {
          $package_suffix = 'trusty_all.deb'
        }
        '15.04': {
          $package_suffix = 'vivid_all.deb'
        }
        '16.04': {
          $package_suffix = 'xenial_all.deb'
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} ${::operatingsystemrelease}.")
        }
      }
    }
    'RedHat': {
      $package_dependencies = []
      $package_provider     = 'rpm'
      $systemd_unit_path    = '/usr/lib/systemd/system'
      if $::operatingsystem == 'Amazon' {
        $package_suffix = 'aws.rpm'
      }
      else {
        case $::operatingsystemmajrelease {
          '5': {
            $package_suffix = 'el5.noarch.rpm'
          }
          '6': {
            $package_suffix = 'el6.noarch.rpm'
          }
          '7': {
            $package_suffix = 'el7.noarch.rpm'
          }
          default: {
            fail("The ${module_name} module is not supported on ${::operatingsystem} ${::operatingsystemrelease}.")
          }
        }
      }
    }
    'Darwin': {
      $package_dependencies = []
      $package_provider     = 'apple'
      $package_suffix       = 'osx.pkg'
    }
    default: {
      fail("The ${module_name} module is not supported on a ${::osfamily} based system.")
    }
  }
}
