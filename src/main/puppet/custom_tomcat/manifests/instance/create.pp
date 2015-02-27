
define custom_tomcat::instance::create (
      $user,
      $group,
      $prefix,
      $catalina_base,
      $instance,
      $instance_name,
      $instance_server_port,
      $instance_http_port,
      $instance_https_port,
      $instance_ajp_port,
      $webapps,
      $logs_directory,
      $java_opts,
      $host_definitions,
      $global_resource_definitions,
      $balancer_name,
      $balancer_proxy_list,
      $balancer_libs_name,
      $balancer_libs_version,
      $balancer_libs_path,
      $config_class,
      $config_options,
      $service_enabled,
  ) {
  
  $service_name  = "custom_${instance_name}"

  notify {"instance=$instance_name": }

  # key_suffix = ruby function in ras_extra_lib, add a suffix to each Hash key
  # this is to allow key duplication in Hiera.
  $real_webapps = key_suffix($webapps, $instance)

  #
  # BEGIN
  #
  anchor { "custom_tomcat::instance::create::${instance_name}::begin": }

  file { "${catalina_base}":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => Anchor["custom_tomcat::instance::create::${instance_name}::begin"],
  }

  if ( ! empty( $logs_directory ) )
  {
    if ! defined(File["${logs_directory}"])
    {
      file { "${logs_directory}":
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0775',
      }
    }
    file { "${logs_directory}/instance${instance}":
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0775',
      require => File["${logs_directory}"],
    } ->
    file { "${catalina_base}/logs":
      ensure  => link,
      target  => "${logs_directory}/instance${instance}",
      force   => true,
      require => File["${catalina_base}"],
      before  => Anchor["custom_tomcat::instance::create::${instance_name}::pre"],
    }
  }
  else
  {
    file { "${catalina_base}/logs":
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0775',
      require => File["${catalina_base}"],
      before  => Anchor["custom_tomcat::instance::create::${instance_name}::pre"],
    }
  }

  #
  # PRE
  #
  anchor { "custom_tomcat::instance::create::${instance_name}::pre": }

  file {  [
            "${catalina_base}/bin",
            "${catalina_base}/conf",
            "${catalina_base}/lib",
            "${catalina_base}/webapps",
            "${catalina_base}/work",
            "${catalina_base}/temp",
          ]:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => Anchor["custom_tomcat::instance::create::${instance_name}::pre"],
    before  => Anchor["custom_tomcat::instance::create::${instance_name}::cfg"],
  } ~>
  exec { "cp_tomcat_${instance_name}":
      command     => "cp -a ${prefix}/tomcat/bin ${catalina_base}/. && cp -a ${prefix}/tomcat/bin ${catalina_base}/.  && cp -a ${prefix}/tomcat/lib ${catalina_base}/. && cp -a ${prefix}/tomcat/conf ${catalina_base}/. && cp -a ${prefix}/tomcat/webapps ${catalina_base}/. && chown -R ${user}:${group} ${catalina_base}",
      refreshonly => true,
      subscribe   => File["${catalina_base}"], 
      before      => Anchor["custom_tomcat::instance::create::${instance_name}::cfg"],
  }

  #
  # CFG
  #
  anchor { "custom_tomcat::instance::create::${instance_name}::cfg": }

  # setenv.sh
  file { "${catalina_base}/bin/setenv.sh":
    ensure  => present,
    content => template("${module_name}/setenv.sh.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => [ Anchor["custom_tomcat::instance::create::${instance_name}::cfg"], File["${catalina_base}/bin"] ],
    before  => Anchor["custom_tomcat::instance::create::${instance_name}::module"],
  }
  # server.xml
  file { "${catalina_base}/conf/server.xml":
    ensure  => present,
    content => template("${module_name}/server.xml.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0644',
    require => [ Anchor["custom_tomcat::instance::create::${instance_name}::cfg"], File["${catalina_base}/conf"] ],
    before  => Anchor["custom_tomcat::instance::create::${instance_name}::module"],
  }
  # catalina.properties
  file { "${catalina_base}/conf/catalina.properties":
    ensure  => present,
    content => template("${module_name}/catalina.properties.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0644',
    require => [ Anchor["custom_tomcat::instance::create::${instance_name}::cfg"], File["${catalina_base}/conf"] ],
    before  => Anchor["custom_tomcat::instance::create::${instance_name}::module"],
  }
  # tomcat-users.xml
  file { "${catalina_base}/conf/tomcat-users.xml":
    ensure  => present,
    content => template("${module_name}/tomcat-users.xml.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0644',
    require => [ Anchor["custom_tomcat::instance::create::${instance_name}::cfg"], File["${catalina_base}/conf"] ],
    before  => Anchor["custom_tomcat::instance::create::${instance_name}::module"],
  }
  # init script
  file { "/etc/init.d/${service_name}":
    ensure  => present,
    content => template("${module_name}/tomcat.init.erb"),
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Anchor["custom_tomcat::instance::create::${instance_name}::cfg"],
    before  => Anchor["custom_tomcat::instance::create::${instance_name}::module"],
  }

  #
  # MODULE
  #
  anchor { "custom_tomcat::instance::create::${instance_name}::module": }

  if ( $config_class ) and ( ! empty( $config_class ) )
  {
    $config = {
      "config_module_${instance_name}_${config_class}" => {
        user     => $user,
        group    => $group,
        catalina_base => $catalina_base,
        instance_name => $instance_name,
        instance => $instance,
        require  => Anchor["custom_tomcat::instance::create::${instance_name}::module"],
        before   => Anchor["custom_tomcat::instance::create::${instance_name}::post"],
      }
    }
    create_resources( "$config_class", $config, $config_options )
  }

  #
  # POST
  #
  anchor { "custom_tomcat::instance::create::${instance_name}::post": }

  $defaults = {
    catalina_base => $catalina_base,
    user          => $user,
    group         => $group,
    service_name  => $service_name,
    require       => Anchor["custom_tomcat::instance::create::${instance_name}::post"],
    before        => Anchor["custom_tomcat::instance::create::${instance_name}::service"],
  }
  create_resources( custom_tomcat::deploy_war, $real_webapps, $defaults )

  #
  # SERVICE
  #
  anchor { "custom_tomcat::instance::create::${instance_name}::service": }

  $service = { "service_${instance_name}" => {
      service_name    => $service_name,
      service_enabled => $service_enabled,
      require         => [ File["/etc/init.d/${service_name}"],
                           Anchor["custom_tomcat::instance::create::${instance_name}::service"] ],
      before          => Anchor["custom_tomcat::instance::create::${instance_name}::end"],
    }
  }
  create_resources( custom_tomcat::instance::service, $service )

  #
  # END
  #
  anchor { "custom_tomcat::instance::create::${instance_name}::end": }
}
