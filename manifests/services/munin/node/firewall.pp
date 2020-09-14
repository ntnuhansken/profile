# Firewall rules for munin node
class profile::services::munin::node::firewall {
  $muninservers = lookup('profile::munin::server')

  ::profile::baseconfig::firewall::custom { 'munin':
    source   => $muninservers,
    port     => 4949,
    protocol => 'tcp'
  }
}
