
class riskim_tomcat::config (
  $instances = hiera_hash('riskim_tomcat::config::instances', {})
)
{
  anchor { "riskim_tomcat::config::begin": }

  if( ! empty( $instances ) )
  {
    validate_hash( $instances )
    create_resources( riskim_tomcat::instance, $instances )
  }

  file { "/etc/init.d/riskim_tomcat":
    ensure  => present,
    content => template("${module_name}/riskim_tomcat.erb"),
    owner   => root,
    group   => root,
    mode    => '0755',
  }

  anchor { "riskim_tomcat::config::end": }
}
