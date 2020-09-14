# Baseconfig for all servers

class profile::baseconfig {

  $installmunin = lookup('profile::munin::install', {
    'default_value' => true,
    'value_type'    => Boolean,
  })

  include ::profile::baseconfig::firewall
  include ::profile::baseconfig::networking
  include ::profile::baseconfig::packages
  include ::profile::baseconfig::puppet
  include ::profile::baseconfig::time
  include ::profile::baseconfig::users

  if ($installmunin) {
    include ::profile::services::munin::node
  }
}
