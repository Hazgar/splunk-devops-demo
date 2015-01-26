# === Authors
#
# Stephane Lapie <stephane.lapie@uk.bnpparibas.com>
#

class java_modcluster_libs::package(
   $packagedir = hiera('java_modcluster_libs::install::packagedir', $java_modcluster_libs::data::packagedir),
   $package = hiera('java_modcluster_libs::install::package', $java_modcluster_libs::data::package),
   $version = hiera('java_modcluster_libs::install::version', $java_modcluster_libs::data::version),
   $prefix = hiera('java_modcluster_libs::install::prefix', $java_modcluster_libs::data::prefix),
)
{
  $archive = "${package}-${version}"

  exec { "untar_$archive":
    command      => "tar -zxf ${packagedir}/${archive}.tar.gz",
    cwd          => "${prefix}",
    onlyif       => "test ! -d '${prefix}/${archive}'",
    user         => root,
  }
  exec { "chown_$archive":
    command      => "chown -R root:root ${prefix}/${archive}",
    user         => root,
    refreshonly  => true,
    subscribe    => Exec["untar_$archive"],
  }
  exec { "chmod_$archive":
    command      => "chmod -R 555 ${prefix}/${archive}",
    user         => root,
    refreshonly  => true,
    subscribe    => Exec["untar_$archive"],
  }
}
