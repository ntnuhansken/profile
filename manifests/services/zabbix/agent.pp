# install zabbix agent
class profile::services::zabbix::agent {

  $zabbix_ip = lookup('profile::zabbix::server::ip')

  class { '::zabbix::agent':
    server          => $zabbix_ip,
    agent_use_ip    => true,
    manage_firewall => true,
  }
}
