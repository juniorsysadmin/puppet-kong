class kong::params {
  $admin_api_listen_address            = '0.0.0.0'
  $admin_api_listen_port               = 8001
  $base_url                            = 'https://downloadkong.org'
  $cassandra_contact_points            = [ '127.0.0.1:9042' ]
  $cassandra_keyspace                  = 'kong'
  $cassandra_replication_strategy      = 'SimpleStrategy'
  $cassandra_replication_factor        = 1
  $cassandra_data_centers              = []
  $cassandra_ssl_enabled               = false
  $cassandra_ssl_verify                = false
  $cassandra_ssl_certificate_authority = undef
  $cassandra_user                      = undef
  $cassandra_password                  = undef
  $cassandra_timeout                   = 5000
  $cluster_advertise                   = undef
  $cluster_encrypt                     = undef
  $cluster_listen_address              = '0.0.0.0'
  $cluster_listen_port                 = 7946
  $cluster_listen_rpc_address          = '127.0.0.1'
  $cluster_listen_rpc_port             = 7373
  $config_file_group                   = 'root'
  $config_file_mode                    = '0644'
  $config_file_owner                   = 'root'
  $config_file_path                    = '/etc/kong/kong.yml'
  $config_file_template                = 'kong/kong.yml.erb'
  $custom_plugins                      = [
    'acl',
    'basic-auth',
    'cors',
    'datadog',
    'file-log',
    'hmac-auth',
    'http-log',
    'ip-restriction',
    'jwt',
    'key-auth',
    'loggly',
    'log-serializers',
    'mashap-analytics',
    'oauth2',
    'rate-limiting',
    'request-size-limiting',
    'request-transformer',
    'response-ratelimiting',
    'request-transformer',
    'runscope',
    'ssl',
    'syslog',
    'tcp-log',
    'udp-log',
  ]
  $database                            = 'cassandra'
  $dns_resolver                        = 'dnsmasq'
  $kong_path                           = '/usr/local/bin/kong'
  $manage_package_dependencies         = true
  $manage_package_fetch                = true
  $manage_init_file                    = true
  $memory_cache_size                   = 128
  $nginx_working_dir                   = '/usr/local/kong/'
  $package_manage                      = true
  $proxy_listen_address                = '0.0.0.0'
  $proxy_listen_port                   = 8000
  $proxy_listen_ssl_address            = '0.0.0.0'
  $proxy_listen_ssl_port               = 8443
  $send_anonymous_reports              = true
  $service_enable                      = true
  $service_ensure                      = 'running'
  $service_manage                      = true
  $ssl_cert_path                       = undef
  $ssl_key_path                        = undef
  $systemd_init_file_template          = 'kong/init/systemd/kong.service.erb'
  $sysv_init_file_template             = 'kong/init/sysv/kong.erb'
  $upstart_init_file_template          = 'kong/init/upstart/kong.conf.erb'
  $use_staging                         = false
  $version                             = '0.7.0'

  case $::osfamily {
    'Debian': {
      $package_dependencies = ['netcat', 'openssl', 'libpcre3', 'dnsmasq', 'procps']
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
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} ${::operatingsystemrelease}.")
        }
      }
    }
    'RedHat': {
      $package_dependencies = undef
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
      $package_dependencies = undef
      $package_suffix       = 'osx.pkg'
    }
    default: {
      fail("The ${module_name} module is not supported on a ${::osfamily} based system.")
    }
  }
}
