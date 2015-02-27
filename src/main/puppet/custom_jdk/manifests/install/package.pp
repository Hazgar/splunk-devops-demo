
class custom_jdk::install::package
{
  package { $custom_jdk::data::package:
    ensure => $custom_jdk::data::version,
  }
}
