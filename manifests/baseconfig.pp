# Baseconfig for all servers

class profile::baseconfig {
  include ::profile::baseconfig::users
  include ::profile::baseconfig::packages
}
