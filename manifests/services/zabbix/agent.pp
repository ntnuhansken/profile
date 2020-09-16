# install zabbix agent
class profile::services::zabbix::agent {

  $zabbix_ip = lookup('profile::zabbix::server::ip')
  $version = lookup('profile::zabbix::version', {
    'default_value' => '5.1',
    'value_type'    => String,
  })

  class { '::zabbix::agent':
    server          => $zabbix_ip,
    zabbix_version  => $version,
    agent_use_ip    => true,
    manage_firewall => true,
  }
}
