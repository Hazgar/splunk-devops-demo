
class riskim_tomcat
{
  anchor { 'riskim_tomcat::begin': }->
  class { 'riskim_tomcat::data': }->
  class { 'riskim_tomcat::install': }->
  class { 'riskim_tomcat::config': }->
# service in 'instance.pp'
  anchor { 'riskim_tomcat::end': }
}
