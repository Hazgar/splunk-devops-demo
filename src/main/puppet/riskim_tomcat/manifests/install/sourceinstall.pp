
class riskim_tomcat::install::sourceinstall
(
  $prefix = hiera( 'riskim_tomcat::install::prefix', $riskim_tomcat::data::prefix ),
  $packagedir = hiera( 'riskim_tomcat::install::packagedir', $riskim_tomcat::data::packagedir ),
  $version = hiera( 'riskim_tomcat::install::version', $riskim_tomcat::data::version ),
  $instancedir = hiera( 'riskim_tomcat::config::instancedir', $riskim_tomcat::data::instancedir ),
  $user = hiera( 'riskim_tomcat::install::user', $riskim_tomcat::data::user ),
  $group = hiera( 'riskim_tomcat::install::group', $riskim_tomcat::data::group ),
)
{
    #if $version =~ /^(\d+)\.([.\d]+)/
    #{
    #  $tomcat_maj_version = $1
    #  $tomcat_sub_version = $2
    #}
    #else
    #{
    #  fail( "Tomcat sourceinstall requires a version specified as riskim_tomcat::install::version (matching /^(\\d+)\\.([.\\d]+)/ )" )
    #}

    #$url = "http://apache.belnet.be/tomcat/tomcat-${tomcat_maj_version}/v${version}/bin"
    $archive = "apache-tomcat-${version}"

    #exec{ 'curl_tomcat':
    #  command => "curl -o ${archive}.tar.gz $url/$archive.tar.gz",
    #  cwd     => $packagedir,
    #  creates => "${packagedir}/${archive}.tar.gz",
    #}

  exec { 'srcinst_untar_tomcat':
    command      => "tar -zxf ${packagedir}/${archive}.tar.gz",
    cwd          => $prefix,
    onlyif       => "test ! -d '${prefix}/${archive}'",
  }
  exec { 'srcinst_chown_tomcat':
    command     => "chown -R ${user}:${group} ${prefix}/${archive}",
    subscribe   => Exec['srcinst_untar_tomcat'],
    refreshonly => true,
  }
  file { "$prefix/tomcat":
    ensure    => link,
    target    => "${prefix}/${archive}",
    subscribe => Exec['srcinst_chown_tomcat'],
    force     => true,
  }
}
