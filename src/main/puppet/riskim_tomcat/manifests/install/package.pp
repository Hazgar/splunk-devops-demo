
class riskim_tomcat::install::package
{
  package { $riskim_tomcat::data::package:
    ensure => $riskim_tomcat::data::version,
  }
}
