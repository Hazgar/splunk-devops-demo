
define riskim_tomcat::deploy_war (
    $file,
    $service_name,
    $catalina_base,
    $artifact_id = undef,
    $artifact_version = 'LATEST',
    $artifact_groupid = undef,
    $user = hiera( 'riskim_tomcat::install:user', $riskim_tomcat::data::user),
    $group = hiera( 'riskim_tomcat::install:group', $riskim_tomcat::data::group),
    $appsdir = hiera( 'riskim_tomcat::install::appsdir', undef),
  )  {

  $file_ext = inline_template( "<%= File.extname(\"${file}\") %>" )
  $webapp_name = inline_template( "<%= File.basename(\"${file}\", \"${file_ext}\") %>" )

  if ( $artifact_id ) and ( ! empty( $artifact_id ) )
     and ( $artifact_groupid ) and ( ! empty( $artifact_groupid ) )
  {
    #
    # Copy WAR file from Maven
    #
    notify { "notify_download_${catalina_base}_${file}":
      message => "downloading artifact: artifactid=${artifact_id} version=${artifact_version} groupid=${artifact_groupid}",
    }->
    file { "delete_${catalina_base}/webapps/${webapp_name}":
      ensure => absent,
      path   => "${catalina_base}/webapps/${webapp_name}",
      force  => true,
      backup => false,
    }->
    file { "delete_${catalina_base}/webapps/${file}":
      ensure => absent,
      path   => "${catalina_base}/webapps/${file}",
      backup => false,
    }->
    maven { "${catalina_base}/webapps/${file}":
      artifactid => $artifact_id,
      version    => $artifact_version,
      groupid    => $artifact_groupid,
      packaging  => "war",
      user       => $user,
      group      => $group,
      require    => [ Class['maven::maven'], Class['maven::setup'] ],
      notify     => Service[$service_name],
    }->
    notify { "notify_war_copied_${catalina_base}_${file}":
      message => "WAR file copied: ${catalina_base}/webapps/${file}",
    }
  }
  elsif ( $appsdir ) and ( ! empty( $appsdir ) )
  {
    #
    # Copy WAR file from File System
    #
    file { "delete_${catalina_base}/webapps/${webapp_name}":
      ensure => absent,
      path   => "${catalina_base}/webapps/${webapp_name}",
      force  => true,
      backup => false,
    }->
    exec { "deploy_${catalina_base}_${file}":
      command     => "cp ${appsdir}/${file} ${catalina_base}/webapps/${file}",
      unless      => "diff ${appsdir}/${file} ${catalina_base}/webapps/${file}",
    }~>
    notify { "notify_deploy_${catalina_base}_${file}":
      message => "deploying war file: ${appsdir}/${file}"
    }~>
    exec { "chown_${catalina_base}_${file}":
      command     => "chown ${user}:${group} ${catalina_base}/webapps/${file}",
      subscribe   => Exec["deploy_${catalina_base}_${file}"],
      refreshonly => true,
      notify      => Service[$service_name],
    }
  }
}
