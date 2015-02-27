
class custom_jdk
{
  anchor { 'custom_jdk::begin': }->
  class { 'custom_jdk::data': }->
  class { 'custom_jdk::install': }->
  anchor { 'custom_jdk::end': }
}
