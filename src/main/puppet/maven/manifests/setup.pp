# === Authors
#
# Stephane Lapie <stephane.lapie@uk.bnpparibas.com>
#

class maven::setup(
    $maven_setup = hiera_hash( 'maven_setup', {} ),
)
{
  validate_hash($maven_setup)
  if ( ! empty($maven_setup) )
  {
    create_resources("maven::settings", $maven_setup)
  }
}
