# Install a tftp server
class profile::services::tftp {
  $tftpserver = lookup('profile::tftp::server', Stdlib::IP::Address::V4)
  $rootdir = '/var/lib/tftpboot/'

  file { $rootdir:
    ensure => 'directory',
  }

  class { '::tftp':
    directory => $rootdir,
    options   => '--secure',
  }

  package { ['syslinux', 'pxelinux']:
    ensure => 'present',
  }

  tftp::file { 'pxelinux.cfg':
    ensure => 'directory',
  }

  tftp::file { 'pxelinux.cfg/default':
    ensure => 'file',
    source => 'puppet:///modules/profile/pxelinux.cfg/default',
  }

  tftp::file { 'pxelinux.0':
    ensure  => 'file',
    source  => '/usr/lib/PXELINUX/pxelinux.0',
    require => Package['pxelinux'],
  }

  tftp::file { 'ldlinux.c32':
    ensure  => 'file',
    source  => '/usr/lib/syslinux/modules/bios/ldlinux.c32',
    require => Package['syslinux'],
  }

  file { '/usr/local/bin/createtftp.sh':
    ensure  => 'file',
    owner   => 'root',
    mode    => '0755',
    content => template('profile/createtftp.erb'),
  }
}
