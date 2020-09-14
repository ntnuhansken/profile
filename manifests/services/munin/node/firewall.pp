# Firewall rules for munin node
class profile::services::munin::node::firewall {
  $muninservers = lookup('profile::munin::servers')

  $muninserverscidr = $muninservers.map | $server | {
    $server + '/32'
  }

  ::profile::baseconfig::firewall::custom { 'munin':
    source   => $muninserverscidr,
    port     => 4949,
    protocol => 'tcp'
  }
}
