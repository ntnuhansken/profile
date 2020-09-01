# Installs KVM/libvirt
class profile::services::libvirt {

  $nets = lookup('profile::kvm::networks', {
    'default_value' => false,
    'value_type'    => Variant[Hash, Boolean],
  })

  if($nets) {
    $networks = $nets.reduce({}) | $memo, $n | {
      $netname = $n[0]
      $dev = $nets[$netname]['bridge']
      $memo + { $netname => {
        'bridge' => $dev,
      } }
    }
  } else {
    $networks = {}
  }

  class { '::libvirt':
    drop_default_net => true,
    create_networks  => $networks,
  }

  libvirt_pool { 'default':
    ensure => absent,
  }
  libvirt_pool { 'vmvg':
    autostart => true,
    type      => 'logical',
    sourcedev => ['/dev/sdb'],
    target    => '/dev/vmvg',
  }
}
