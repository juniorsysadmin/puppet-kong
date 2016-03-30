# PRIVATE CLASS: do not call directly
class kong::service {

  if $kong::service_manage {
    service { 'kong':
      ensure => $kong::service_ensure,
      enable => $kong::service_enable,
    }
  }

}