# Install zabbix server
class profile::services::zabbix::server {

  include ::profile::services::zabbix::firewall

  $zabbix_url = lookup('profile::zabbix::url')
  $db_pass = lookup('profile::zabbix:database::password')
  $version = lookup('profile::zabbix::version', {
    'default_value' => '5.1',
    'value_type'    => String,
  })

  class { '::zabbix':
    database_type     => 'mysql',
    zabbix_url        => $zabbix_url,
    zabbix_version    => $version,
    database_user     => 'zabbix',
    database_password => $db_pass,
  }
}
