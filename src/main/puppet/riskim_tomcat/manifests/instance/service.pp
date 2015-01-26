
define riskim_tomcat::instance::service (
      $service_name,
      $service_enabled = false,
  ) {
 
  service { "${service_name}":
     ensure     => $service_enabled,
     enable     => $service_enabled,
     hasstatus  => true,
     hasrestart => true,
  }
}
