# Open firewall for global access on given port
define profile::baseconfig::firewall::global (
  Variant[Integer, Array[Integer], String] $port,
  String                                   $protocol,
) {

  require ::profile::baseconfig::firewall

  firewall { "5 Accept service ${name} from ${net}":
    proto   => $protocol,
    dport   => $port,
    acction => 'accept',
    source  => $net,
  }
}
