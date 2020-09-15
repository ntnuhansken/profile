# Firewall rules for apache
class profile::services::apache::firewall {
  ::profile::baseconfig::firewall::internal { 'apache':
    protocol => 'tcp',
    port     => [80,443],
  }
}
