# Copyright 2011 MaestroDev
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Define: maven::settings
#
# A puppet recipe to set the contents of the settings.xml file
#
define maven::settings( $home = undef, $user = 'root',
  $servers = {}, $mirrors = {}, $repositories = {}, $properties = {}, $local_repo = '', $proxies = [], $purge = undef ) {

  if $home == undef {
    $home_real = $user ? {
      'root'  => '/root',
      default => "/home/${user}"
    }
  }
  else {
    $home_real = $home
  }

  if $purge != undef {
    if $local_repo == '' {
      $purge_pkg = "${home_real}/.m2/repository/${purge}"
    }
    else {
      $purge_pkg = "${local_repo}/${purge}"
    }
    file { $purge_pkg:
      ensure => absent,
      force  => true,
      backup => false,
    }
  }

  file { "${home_real}/.m2":
    ensure => directory,
    owner  => $user,
    mode   => '0700',
  } ->
  file { "${home_real}/.m2/settings.xml":
    owner   => $user,
    mode    => '0600',
    content => template('maven/settings.xml.erb'),
  }

}
