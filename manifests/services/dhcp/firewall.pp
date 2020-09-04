# Firewall rules for DHCP
class profile::services::dhcp::firewall {
  ::profile::baseconfig::firewall::global { 'DHCP':
    protocol => 'udp',
    port     => [67,68],
  }
}
