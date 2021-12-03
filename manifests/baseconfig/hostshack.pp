# Host file hack for hansken nodes
class profile::baseconfig::hostshack {
  $domain = lookup('profile::hansken::domainname')
  $ip = $facts['networking']['ip']
  $hostname = $facts['hostname']

  host { "${hostname}.${domain}":
    ensure       => 'present',
    host_aliases => [ $hostname ],
    ip           => $ip,
    target       => '/etc/hosts',
  }
}
