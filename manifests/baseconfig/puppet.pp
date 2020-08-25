# Configure puppet
class profile::baseconfig::puppet {
  $environment = lookup('profile::puppet::environment', String)
  $puppetserver = lookup('profile:puppet::hostname', Stdlib::Fqdn)
  $agentconfigfile = '/etc/puppetlabs/puppet/puppet.conf'
  $agentpackage = 'puppet-agent'

  package { $agentpackage:
    ensure => 'present',
  }

  ini_setting { 'Puppet environment':
    ensure  => present,
    path    => $agentconfigfile,
    section => 'agent',
    setting => 'environment',
    value   => $environment,
    notify  => Service['puppet'],
    require => Package[$agentpackage],
  }

  ini_setting { 'Puppet server':
    ensure  => present,
    path    => $agentconfigfile,
    section => 'agent',
    setting => 'server',
    value   => $puppetserver,
    notify  => Service['puppet'],
    require => Package[$agentpackage],
  }

  service { 'puppet':
    ensure  => 'running',
    enable  => true,
    require => Package[$agentpackage],
  }
}
