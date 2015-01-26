#
# JDK installation wrapper class
#
class riskim_jdk::install (
  $type = hiera( 'riskim_jdk::install::type', $riskim_jdk::data::type ),
) inherits ::riskim_jdk::data
{
  if $type =~ /^(package|sourceinstall)$/  
  {
    class{ "::riskim_jdk::install::$type": }
  }
  else
  {
    fail( "riskim_jdk::install::type must be one of [ 'package', 'sourceinstall' ]. Found $type" )
  }
}
