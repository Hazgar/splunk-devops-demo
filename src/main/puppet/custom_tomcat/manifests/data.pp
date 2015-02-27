
class custom_tomcat::data
{
  case $::operatingsystem
  {
    centos, redhat: {
      $user        = 'tomcat'
      $group       = 'www'
      $packagedir  = '/root/work'
      $instancedir = '/opt/tomcat-instances'
      $prefix      = '/opt'
      $type        = 'sourceinstall'
      $base_server_port = 8005
      $base_http_port = 8080
      $base_https_port = 8443
      $base_ajp_port = 8009
      $service_enable  = 'true'
      $balancer_name = ""
      $balancer_proxy_list = ""
    }
    default:
    { 
      fail("Unknown OS: $::operatingsystem")
    }
  }
}
