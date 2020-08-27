# Baseconfig for all servers

class profile::baseconfig {
  include ::profile::baseconfig::firewall
  include ::profile::baseconfig::networking
  include ::profile::baseconfig::packages
  include ::profile::baseconfig::puppet
  include ::profile::baseconfig::time
  include ::profile::baseconfig::users
}
