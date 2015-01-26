# === Authors
#
# Stephane Lapie <stephane.lapie@uk.bnpparibas.com>
#
class java_modcluster_libs::data {
  case $::operatingsystem
  {
    centos, redhat: {
      $packagedir     = '/tmp/java_modcluster_libs_pkgs'
      $group          = 'root'
      $user           = 'root'
      $package        = 'jboss-mod_cluster'
      $version        = '1.1.3'
      $prefix         = '/usr/java/'
    }
    default:
    { 
      fail("Unknown OS: $::operatingsystem")
    }
  }
}
