# PRIVATE CLASS: do not call directly
class kong::config inherits kong {

  if $kong::config_file_path == '/etc/kong/kong.yml' {
    file { '/etc/kong':
      ensure => directory,
      group  => $kong::config_file_group,
      mode   => '0755',
      owner  => $kong::config_file_owner,
    }
  }

  file { $kong::config_file_path:
    ensure  => file,
    content => template($kong::config_file_template),
    group   => $kong::config_file_group,
    mode    => $kong::config_file_mode,
    owner   => $kong::config_file_owner,
  }
}