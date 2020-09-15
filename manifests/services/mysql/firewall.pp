# Firewall rules for mysql
class profile::services::mysql::firewall {
  ::profile::baseconfig::firewall::internal { 'mysql':
    protocol => 'tcp',
    port     => 3306,
  }
}
