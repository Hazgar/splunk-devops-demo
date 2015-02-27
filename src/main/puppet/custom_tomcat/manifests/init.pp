
class custom_tomcat
{
  anchor { 'custom_tomcat::begin': }->
  class { 'custom_tomcat::data': }->
  class { 'custom_tomcat::install': }->
  class { 'custom_tomcat::config': }->
# service in 'instance.pp'
  anchor { 'custom_tomcat::end': }
}
