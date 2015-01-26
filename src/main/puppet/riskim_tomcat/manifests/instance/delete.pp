
define riskim_tomcat::instance::delete (
      $instance,
      $instance_name,
      $catalina_base,
      $logs_directory,
  ) {
  
  $service_name  = "riskim_${instance_name}"

  notify {"instance=$instance_name": }

  #
  # BEGIN
  #
  anchor { "riskim_tomcat::instance::delete::${instance_name}::begin": }

  file { "${catalina_base}":
    ensure  => absent,
    force   => true,
    backup  => false,
    require => Anchor["riskim_tomcat::instance::delete::${instance_name}::begin"],
    before  => Anchor["riskim_tomcat::instance::delete::${instance_name}::end"],
  }

  if ( ! empty( $logs_directory ) )
  {
    file { "${logs_directory}/instance${instance}":
      ensure  => absent,
      force   => true,
      backup  => false,
      require => File["${catalina_base}"],
      before  => Anchor["riskim_tomcat::instance::delete::${instance_name}::end"],
    }
  }
  else
  {
    file { "${catalina_base}/logs":
      ensure  => absent,
      force   => true,
      backup  => false,
      require => File["${catalina_base}"],
      before  => Anchor["riskim_tomcat::instance::delete::${instance_name}::end"],
    }
  }

  file { "/etc/init.d/${service_name}":
    ensure  => absent,
    require => File["${catalina_base}"],
    before  => Anchor["riskim_tomcat::instance::delete::${instance_name}::end"],
  }

  #
  # END
  #
  anchor { "riskim_tomcat::instance::delete::${instance_name}::end": }
}
