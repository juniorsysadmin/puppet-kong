# PRIVATE CLASS: do not call directly
class kong::config inherits kong {

  file { $kong::config_file_path:
    ensure       => file,
    content      => template($kong::config_file_template),
    group        => $kong::config_file_group,
    mode         => $kong::config_file_mode,
    owner        => $kong::config_file_owner,
    validate_cmd => "${kong::kong_path} check %",
  }
}