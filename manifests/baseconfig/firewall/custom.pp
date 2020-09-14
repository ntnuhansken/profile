# Create firewall rules with a given source address
define profile::baseconfig::firewall::custom (
  Variant[Integer, Array[Integer], String]      $port,
  String                                        $protocol,
  Variant[Stdlib::IP::Address::V4::CIDR,
          Array[Stdlib::IP::Address::V4::CIDR]] $source = [],
) {

  require ::profile::baseconfig::firewall

  $sources = [] + $source
  $sources.each | $net | {
    firewall { "5 Accept service ${name} from ${net}":
      proto  => $protocol,
      dport  => $port,
      action => 'accept',
      source => $net,
    }
  }
}

