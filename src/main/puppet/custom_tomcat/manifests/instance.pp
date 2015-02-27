
define custom_tomcat::instance (
      $parent               = undef,
      $clone                = 0,
      $ensure               = present,
      $service_enabled      = false,
      $webapps              = {},
      $java_opts            = [],
      $logs_directory       = undef,
      $host_definitions     = [],
      $global_resource_definitions = [],
      $config_class         = undef,
      $config_options       = {},
      $user                 = hiera( 'custom_tomcat::install::user', $custom_tomcat::data::user ),
      $group                = hiera( 'custom_tomcat::install::group', $custom_tomcat::data::group ),
      $prefix               = hiera( 'custom_tomcat::install::prefix', $custom_tomcat::data::prefix ),
      $instancedir          = hiera( 'custom_tomcat::config::instancedir', $custom_tomcat::data::instancedir ),
      $instances            = hiera('custom_tomcat::config::instances', {} ),
      $base_server_port     = hiera( 'custom_tomcat::config::base_server_port', $custom_tomcat::data::base_server_port ),
      $base_http_port       = hiera( 'custom_tomcat::config::base_http_port', $custom_tomcat::data::base_http_port ),
      $base_https_port      = hiera( 'custom_tomcat::config::base_https_port', $custom_tomcat::data::base_https_port ),
      $base_ajp_port        = hiera( 'custom_tomcat::config::base_ajp_port', $custom_tomcat::data::base_ajp_port ),
      $global_java_opts     = hiera( 'custom_tomcat::config::java_opts', [] ),
      $balancer_name        = $custom_tomcat::data::balancer_name,
      $balancer_proxy_list  = $custom_tomcat::data::balancer_proxy_list,
      $balancer_libs_name   = hiera( 'java_modcluster_libs::install::package', undef),
      $balancer_libs_version= hiera( 'java_modcluster_libs::install::version', undef),
      $balancer_libs_path   = hiera( 'java_modcluster_libs::install::prefix', undef),
  ) {
  
  if ( $parent == undef ) {
    $real_parent = $name
  } else {
    $real_parent = $parent
  }
 
  $instance_idx = inline_template( "<%= @instances.keys.sort.index('$real_parent') %>" )
  $instance = inline_template( "<%= @instance_idx.to_i + @clone.to_i %>" )
  $instance_name = "${real_parent}${instance}"
  $catalina_base = "${instancedir}/${instance_name}"

  # Tomcat ports
  $instance_server_port = inline_template( "<%= @base_server_port.to_i + @instance.to_i %>" )
  $instance_http_port = inline_template( "<%= @base_http_port.to_i + @instance.to_i %>" )
  $instance_https_port = inline_template( "<%= @base_https_port.to_i + @instance.to_i %>" )
  $instance_ajp_port = inline_template( "<%= @base_ajp_port.to_i + @instance.to_i %>" )

  # Java options merge
  # cloned instances $global_java_opts is nullified at declaration
  $final_java_opts = unique( flatten( [$java_opts, $global_java_opts] ) )

  #
  # BEGIN
  #
  anchor { "custom_tomcat::instance::${instance_name}::begin": }
  if ( $ensure == "present" ) {
    $create = { "custom_tomcat::instance::create::${instance_name}" => {
      user                 => $user,
      group                => $group,
      prefix               => $prefix,
      instance             => $instance,
      instance_name        => $instance_name,
      instance_server_port => $instance_server_port,
      instance_http_port   => $instance_http_port,
      instance_https_port  => $instance_https_port,
      instance_ajp_port    => $instance_ajp_port,
      catalina_base        => $catalina_base,
      webapps              => $webapps,
      logs_directory       => $logs_directory,
      java_opts            => $final_java_opts,
      host_definitions     => $host_definitions,
      global_resource_definitions => $global_resource_definitions,
      balancer_name        => $balancer_name,
      balancer_proxy_list  => $balancer_proxy_list,
      balancer_libs_name   => $balancer_libs_name,
      balancer_libs_version=> $balancer_libs_version,
      balancer_libs_path   => $balancer_libs_path,
      config_class         => $config_class,
      config_options       => $config_options,
      service_enabled      => $service_enabled,
      require              => Anchor["custom_tomcat::instance::${instance_name}::begin"],
      before               => Anchor["custom_tomcat::instance::${instance_name}::clone"],
    }}
    create_resources( "custom_tomcat::instance::create", $create)
  } else {
    $delete = { "custom_tomcat::instance::delete::${instance_name}" => {
      instance             => $instance,
      instance_name        => $instance_name,
      catalina_base        => $catalina_base,
      logs_directory       => $logs_directory,
      require              => Anchor["custom_tomcat::instance::${instance_name}::begin"],
      before               => Anchor["custom_tomcat::instance::${instance_name}::clone"],
    }}
    create_resources( "custom_tomcat::instance::delete", $delete)
  }

  #
  # CLONE
  #
  anchor { "custom_tomcat::instance::${instance_name}::clone": }
  if ( $clone > 0 )
  {
    $next_clone= $clone - 1
    $clone_def = { "${real_parent}${clone}" => {
        parent                => $real_parent,
        clone                 => $next_clone,
        ensure                => $ensure,
        service_enabled       => $service_enabled,
        java_opts             => $final_java_opts,
        global_java_opts      => [], # empty array to avoid java_opts merge loop
        webapps               => $webapps,
        host_definitions      => $host_definitions,
        global_resource_definitions => $global_resource_definitions,
        logs_directory        => $logs_directory,
        config_class          => $config_class,
        config_options        => $config_options,
        balancer_name         => $balancer_name,
        balancer_proxy_list   => $balancer_proxy_list,
        require               => Anchor["custom_tomcat::instance::${instance_name}::clone"],
        before                => Anchor["custom_tomcat::instance::${instance_name}::end"],
      }
    }
    create_resources( custom_tomcat::instance, $clone_def )
  }
  #
  # END
  #
  anchor { "custom_tomcat::instance::${instance_name}::end": }
}
