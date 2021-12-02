# Configure puppet
class profile::baseconfig::puppet {
  $environment = lookup('profile::puppet::environment', String)
  $puppetserver = lookup('profile::puppet::hostname', Stdlib::Fqdn)
  $caserver = lookup('profile::puppet::caserver', Stdlib::Fqdn)
  $agentconfigfile = '/etc/puppetlabs/puppet/puppet.conf'
  $runinterval = lookup('profile::puppet::runinterval', {
    'default_value' => '30m',
    'value_type'    => String,
  })

  $collection = lookup('profile::puppet::collection', {
    'value_type' => String,
  })

  $config = [
    {'section' => 'agent', 'setting' => 'environment', 'value' => $environment},
    {'section' => 'agent', 'setting' => 'runinterval', 'value' => $runinterval},
  ]

  class { 'puppet_agent':
    config     => $config,
    collection => $collection,
  }

  ini_setting { 'Puppet server':
    ensure  => present,
    path    => $agentconfigfile,
    section => 'agent',
    setting => 'server',
    value   => $puppetserver,
  }
  ini_setting { 'Puppet caserver':
    ensure  => present,
    path    => $agentconfigfile,
    section => 'agent',
    setting => 'ca_server',
    value   => $caserver,
  }
}
