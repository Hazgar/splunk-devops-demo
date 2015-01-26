#
# Tomcat installation wrapper class
#
class riskim_tomcat::install (
  $type = hiera( 'riskim_tomcat::install::type', $riskim_tomcat::data::type ),
)
{
  if ( $type =~ /^(package|sourceinstall)$/ )
  {
    class{ "riskim_tomcat::install::$type": }
  }
  else
  {
    fail( "riskim_tomcat::install::type must be one of [ 'package', 'sourceinstall' ]. Found $type" )
  }
}
