# PRIVATE CLASS: do not call directly
class kong::install {

  if $kong::manage_package_dependencies {
    ensure_packages($kong::package_dependencies)
  }

  if $kong::manage_package_fetch {
    if $kong::use_staging {
      include ::staging
      staging::file { "kong-${kong::version}.${kong::package_suffix}":
        source => $kong::download_url,
        target => "/opt/kong-${kong::version}.${kong::package_suffix}",
      }
    } else {
      include ::archive
      archive { "/opt/kong-${kong::version}.${kong::package_suffix}":
        ensure => present,
        source => $kong::download_url,
      }
    }
  }

  if $kong::package_manage {
    if $kong::manage_package_fetch {
      package { 'kong':
        ensure => $kong::version,
        source => "/opt/kong-${kong::version}.${kong::package_suffix}",
      }
    } else {
      package { 'kong:':
        ensure => $kong::version,
      }
    }
  }
}