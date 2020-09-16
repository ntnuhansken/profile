# Install zabbix server
class profile::services::zabbix::server {

  include ::profile::services::zabbix::firewall

  $zabbix_url = lookup('profile::zabbix::url')

  class { '::zabbix':
    database_type => 'mysql',
    zabbix_url    => $zabbix_url,
  }
}
