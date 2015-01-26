
class riskim_jdk::install::package
{
  package { $riskim_jdk::data::package:
    ensure => $riskim_jdk::data::version,
  }
}
