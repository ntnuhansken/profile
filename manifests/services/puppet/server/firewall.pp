# Firewall rules for puppetserver
class profile::services::puppet::server::firewall {
  ::profile::baseconfig::firewall::internal { 'puppetmaster':
    protocol => 'tcp',
    port     => 8140,
  }
}
