# Install zabbix server all-in-one
class profile::services::zabbix {

  require ::profile::services::mysql
  require ::profile::services::apache
}
