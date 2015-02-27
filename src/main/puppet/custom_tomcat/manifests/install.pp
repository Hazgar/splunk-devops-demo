#
# Tomcat installation wrapper class
#
class custom_tomcat::install (
  $type = hiera( 'custom_tomcat::install::type', $custom_tomcat::data::type ),
)
{
  if ( $type =~ /^(package|sourceinstall)$/ )
  {
    class{ "custom_tomcat::install::$type": }
  }
  else
  {
    fail( "custom_tomcat::install::type must be one of [ 'package', 'sourceinstall' ]. Found $type" )
  }
}
