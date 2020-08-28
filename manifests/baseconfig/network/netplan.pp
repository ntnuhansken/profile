# Configure networking with netplan
class profile::baseconfig::network::netplan (Hash $nics) {
  $dns_servers = lookup('profile::dns::nameservers', {
    'default_value' => undef,
  })
  $dns_search = lookup('profile::dns::searchdomain', {
    'default_value' => undef,
  })

  $ethernets = $nics.reduce({}) | $memo, $n | {
    $nic = $n[0]
    $method = $nics[$nic]['ipv4']['method']
    if($method == 'dhcp') {
      $dhcp = { 'dhcp4' => true }
      $memo + { $nic => $dhcp }
    }
    elsif($method == 'manual') {
      $manual = { 'dhcp4' => false }
      $memo + { $nic => $dhcp }
    }
    else {
      if($nics[$nic]['ipv4']['address']) {
        $v4address = $nics[$nic]['ipv4']['address']
        $v4mask = netmask_to_masklen($nics[$nic]['ipv4']['netmask'])
        $v4cidr = [ "${v4address}/${v4mask}" ]
      } else {
        $v4cidr = []
      }
      $gateway = $nics[$nic]['ipv4']['gateway']

      $memo + { $nic => {
        'addresses'      => $v4cidr,
        'gateway4'       => $gateway,
        'nameservers'    => {
          'addresses' => split($dns_servers, ' '),
          'search'    => [ $dns_search ],
        },
      }
      }
    }
  }

  class { '::netplan':
    ethernets => $ethernets,
  }
}
