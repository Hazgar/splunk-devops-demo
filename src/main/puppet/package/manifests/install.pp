#
# == Class: package::install
#
# The package::install class adds, modifies or removes the package install as needed
#
# === Parameters
#
#   The defaults are fetched via hiera from package::data.
#   They can also be set in any other hiera data file.
#
# [*packages*]
#   A hash specifying all needed params for the package type
#
# === Variables
#
# No variables are used in the package base class
#
# === Examples
#
#  class { 'package::install': }
#
# === Hiera
#
#  packages:
#    java-1.6.0-openjdk:
#      #ensure: 1.6.0.0
#      #ensure: absent
#      ensure: 1.6.0.0-1.48.1.11.3.el6_2
#    wget:
#      ensure: present
#
# === Authors
#
# Stefan Goethals <stefan.goethals@super-visions.com>
#
# === Copyright
#
# Copyright 2012 Super-Visions, unless otherwise noted.
#
class package::install( $packages = hiera_hash('packages', {} ) )
{
  validate_hash( $packages )
  if( $packages )
  {
    create_resources( package, $packages )
  }
}
