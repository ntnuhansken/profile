# Firewall for TFTP
class profile::services::tftp::firewall {

  ::profile::baseconfig::firewall::global { 'TFTP':
    protocol => 'udp',
    port     => 69,
  }
}
