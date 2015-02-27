
class custom_tomcat::install::package
{
  package { $custom_tomcat::data::package:
    ensure => $custom_tomcat::data::version,
  }
}
