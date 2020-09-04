# Firewall rules for DHCP
class profile::services::dhcp::firewall {
  ::profile::baseconfig::firwall::global { 'DHCP':
    protocol => 'udp',
    port     => [67,68],
  }
}
