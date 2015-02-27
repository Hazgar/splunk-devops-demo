#
# JDK installation wrapper class
#
class custom_jdk::install (
  $type = hiera( 'custom_jdk::install::type', $custom_jdk::data::type ),
) inherits ::custom_jdk::data
{
  if $type =~ /^(package|sourceinstall)$/  
  {
    class{ "::custom_jdk::install::$type": }
  }
  else
  {
    fail( "custom_jdk::install::type must be one of [ 'package', 'sourceinstall' ]. Found $type" )
  }
}
