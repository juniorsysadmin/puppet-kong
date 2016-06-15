# PRIVATE CLASS: do not call directly
class kong::install {

  if $kong::package_manage {

    if ! empty($kong::package_dependencies) {
      ensure_packages($kong::package_dependencies)
    }

    if $kong::manage_package_fetch {

      if $kong::use_staging {
        include ::staging
        staging::file { "kong-${kong::version}.${kong::package_suffix}":
          source => $kong::download_url,
          target => "${kong::staging_dir}/kong-${kong::version}.${kong::package_suffix}",
        }
      } else {
        include ::archive
        archive { "${kong::staging_dir}/kong-${kong::version}.${kong::package_suffix}":
          ensure => present,
          source => $kong::download_url,
        }
      }

      # Package providers apple, dpkg, rpm support the source attribute (apt
      # and yum do not). Both dpkg and rpm support the upgradeable
      # package provider feature but only rpm supports versionable

      if $kong::package_provider != 'apple' {
        $_package_ensure = latest
      } else {    
        $_package_ensure = present
      }
      
      package { 'kong':
        ensure   => $_package_ensure,
        provider => $kong::package_provider,
        source   => "${kong::staging_dir}/kong-${kong::version}.${kong::package_suffix}",
      }

    }

    # Install package from your local repository using the native package provider
    package { 'kong:':
      ensure => $kong::version,
    }

  }

}
