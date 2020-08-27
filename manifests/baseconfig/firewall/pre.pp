
# This class installs and configures firewall pre.
class profile::baseconfig::firewall::pre {
  Firewall {
    require => undef,
  }

  $mgmt_nets = lookup('profile::firewall::management::networks', {
    'value_type'    => Variant[Array[Stdlib::IP::Address::V4::CIDR], Boolean],
    'default_value' => false,
  })

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 reject local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  }->
  firewall { '003 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }

  if($mgmt_nets) {
    $mgmt_nets.each |$net| {
      firewall { "004 accept incoming SSH from ${net}":
        proto  => 'tcp',
        dport  => 22,
        source => $net,
        action => 'accept',
      }
    }
  } else {
    firewall { '004 accept incoming SSH':
      proto  => 'tcp',
      dport  => 22,
      action => 'accept',
    }
  }

  firewall { '005 accept DHCP':
    proto  => 'udp',
    dport  => 68,
    action => 'accept',
  }
}
