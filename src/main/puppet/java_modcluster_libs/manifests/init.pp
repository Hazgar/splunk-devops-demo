# === Authors
#
# Stephane Lapie <stephane.lapie@uk.bnpparibas.com>
#

class java_modcluster_libs
{
  anchor { 'java_modcluster_libs::begin': }->
  class { 'java_modcluster_libs::data': }->
  class { 'java_modcluster_libs::package': }->
  anchor { 'java_modcluster_libs::end': }
}
