# Install a tftp server
class profile::services::tftp {
  $rootdir = '/var/lib/tftboot/'

  class { '::tftp':
    directory => $rootdir,
    options   => '--secure',
  }

  package { ['syslinux', 'pxelinux']:
    ensure => 'present',
  }

  file { "${rootdir}pxelinux.0":
    ensure  => 'file',
    source  => '/usr/lib/PXELINUX/pxelinux.0',
    require => Package['pxelinux'],
  }

  file { "${rootdir}ldlinux.c32":
    ensure  => 'file',
    source  => '/usr/lib/syslinux/modules/bios/ldlinux.c32',
    require => Package['syslinux'],
  }
}
