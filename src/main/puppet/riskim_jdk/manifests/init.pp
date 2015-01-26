
class riskim_jdk
{
  anchor { 'riskim_jdk::begin': }->
  class { 'riskim_jdk::data': }->
  class { 'riskim_jdk::install': }->
  anchor { 'riskim_jdk::end': }
}
