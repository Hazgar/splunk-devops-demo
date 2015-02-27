
class custom_jdk::data
{
  case $::operatingsystem
  {
    centos, redhat: {
      $user        = 'root'
      $group       = 'root'
      $packagedir  = '/root/work'
      $prefix      = '/opt'
      $type        = 'sourceinstall'
    }
    default:
    { 
      fail("Unknown OS: $::operatingsystem")
    }
  }
}
