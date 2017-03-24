# == Class: kong::initscripts
#
# Class to install init scripts for kong
#
class kong::initscripts inherits kong {
  # FIXME Darwin launchd file
  if $kong::manage_init_file {

    $_init_file_template = $::service_provider ? {
      'systemd' => $kong::systemd_init_file_template,
      'upstart' => $kong::upstart_init_file_template,
      default   => $kong::sysv_init_file_template,
    }

    $_init_script_file_path = $::service_provider ? {
      'systemd' => "${systemd_unit_path}/kong.service",
      'upstart' => '/etc/init/kong.conf',
      default   => '/etc/init.d/kong',
    }

    $_init_script_file_mode = $::service_provider ? {
      /(systemd|upstart)/ => '0644',
      default             => '0755',
    }

    file { $_init_script_file_path:
        ensure  => file,
        content => template($_init_file_template),
        group   => '0',
        mode    => $_init_script_file_mode,
        owner   => 'root',
    }

    if $::service_provider == 'systemd' {
      include ::systemd
      File[$_init_script_file_path] ~> Exec['systemctl-daemon-reload']
    }
  }

}

