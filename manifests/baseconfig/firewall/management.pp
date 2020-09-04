# Open firewall for management networks on given port
define profile::baseconfig::firewall::management (
  Variant[Integer, Array[Integer], String] $port,
  String                                   $protocol,
) {

  require ::profile::baseconfig::firewall

  $nets = lookup('profile::firewall::management::networks', Array[Stdlib::IP::Address::V4::CIDR])

  $nets.each | $net | {
    firewall { "5 Accept service ${name} from ${net}":
      proto   => $protocol,
      dport   => $port,
      acction => 'accept',
      source  => $net,
    }
  }
}
