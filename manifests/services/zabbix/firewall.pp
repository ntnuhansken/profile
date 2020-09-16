# Firewall rules for zabbix server
class profile::services::zabbix::firewall {
  ::profile::baseconfig::firewall::internal { 'zabbix-server':
    protocol => 'tcp',
    port     => 10051,
  }
}
