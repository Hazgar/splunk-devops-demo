
class custom_tomcat::config (
  $instances = hiera_hash('custom_tomcat::config::instances', {})
)
{
  anchor { "custom_tomcat::config::begin": }

  if( ! empty( $instances ) )
  {
    validate_hash( $instances )
    create_resources( custom_tomcat::instance, $instances )
  }

  file { "/etc/init.d/custom_tomcat":
    ensure  => present,
    content => template("${module_name}/custom_tomcat.erb"),
    owner   => root,
    group   => root,
    mode    => '0755',
  }

  anchor { "custom_tomcat::config::end": }
}
