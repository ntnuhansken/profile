# Configure networking with ifupdown
class profile::baseconfig::network::ifupdown (Hash $nics) {
  $dns_servers = lookup('profile::dns::nameservers', {
    'default_value' => undef,
  })
  $dns_search = lookup('profile::dns::searchdomain', {
    'default_value' => undef,
  })

  $dns_search_real = join($dns_search, ' ')

  $nics.each | $nic, $params | {
    $v4gateway = $params['ipv4']['gateway']
    $method = $params['ipv4']['method']
    if($method == 'dhcp') {
      network::interface { $nic:
        interface     => $nic,
        enable_dhcp   => true,
        nm_controlled => 'no',
      }
    }
    else {
      # These will all default to undef if not present in the hash from hiera
      $v4address = $params['ipv4']['address']
      $v4netmask = $params['ipv4']['netmask']
      $primary = $params['ipv4']['primary']

      network::interface { $nic:
        interface       => $nic,
        method          => $method,
        ipaddress       => $v4address,
        netmask         => $v4netmask,
        gateway         => $v4gateway,
        dns_nameservers => $dns_servers,
        dns_search      => $dns_search_real,
      }
    }
  }
}
