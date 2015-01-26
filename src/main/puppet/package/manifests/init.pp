
class package
{
  anchor { 'package::start': }->
  class { 'package::install': }->
  anchor { 'package::end': }
}