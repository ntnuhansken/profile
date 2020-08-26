# This class configures the network interfaces of a node based on data from
# hiera.
class profile::baseconfig::networking {
  # Configure interfaces as instructed in hiera.
  $if_to_configure = lookup('profile::baseconfig::network::interfaces', {
    'default_value' => false,
    'value_type'    => Variant[Hash,Boolean],
  })
  if($if_to_configure) {
    $distro = $facts['os']['release']['major']
    if(versioncmp($distro, '16.04') >= 0) {
      class { '::profile::baseconfig::network::netplan':
        nics => $if_to_configure,
      }
    }
    else {
      class { '::profile::baseconfig::network::ifupdown':
        nics => $if_to_configure,
      }
    }
  }
}
