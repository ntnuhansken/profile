# Add deployment user config for ansible
# The actual user should be defined in hiera
class profile::baseconfig::deployment {

  include ::sudo

  group { 'deployment':
    ensure => present,
    gid    => 701,
  }

  sudo::conf { 'deployment':
    priority => 10,
    source   => 'puppet:///modules/profile/sudo/deployment_sudoers',
  }
}
