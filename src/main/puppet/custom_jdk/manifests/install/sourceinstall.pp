
class custom_jdk::install::sourceinstall
(
  $prefix = hiera( 'custom_jdk::install::prefix', $custom_jdk::data::prefix ),
  $packagedir = hiera( 'custom_jdk::install::packagedir', $custom_jdk::data::packagedir ),
  $version = hiera( 'custom_jdk::install::version', $custom_jdk::data::version ),
  $user = hiera( 'custom_jdk::install::user', $custom_jdk::data::user ),
  $group = hiera( 'custom_jdk::install::group', $custom_jdk::data::group ),
)
{
  $archive = "jdk${version}"

  if ( ! defined(File[$prefix]) )
  {
    file { "$prefix":
      ensure => directory,
      owner  => $user,
      group  => $group,
      mode   => '0755',
    }
  }

  exec { "untar_$archive":
    command => "tar -zxf ${packagedir}/${archive}.tar.gz",
    cwd     => $prefix,
    onlyif  => "test ! -d '${prefix}/${archive}'",
    user    => $user,
  }
  exec { "chown_$archive":
    command     => "chown -R ${user}:${group} '${prefix}/${archive}'",
    cwd         => $prefix,
    user        => $user,
    refreshonly => true,
    subscribe   => Exec["untar_$archive"],
  }
  file { "${prefix}/${archive}/bin/postinstall.sh":
    ensure  => present,
    content => template("${module_name}/postinstall.sh.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0555',
    require => Exec["untar_$archive"],
  }
  file { "${prefix}/${archive}/bin/postunstall.sh":
    ensure  => present,
    content => template("${module_name}/postunstall.sh.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0555',
    require => Exec["untar_$archive"],
  }
  exec { 'postinstall_jdk':
    command     => "${prefix}/${archive}/bin/postinstall.sh",
    cwd         => $prefix,
    user        => $user,
    refreshonly => true,
    subscribe   => File["${prefix}/${archive}/bin/postinstall.sh"],
  }
}
