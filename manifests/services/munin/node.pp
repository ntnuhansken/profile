# Install munin-node
class profile::services::munin::node {

  include ::profile::services::munin::node::firewall
  include ::profile::services::munin::plugin::general

  $muninservers = lookup('profile::munin::servers', Array[Stdlib::IP::Address])

  class { '::munin::node':
    allow          => $muninservers,
    purge_configs  => true,
    service_ensure => 'running',
  }
}
