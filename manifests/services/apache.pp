# Install basic apache
class profile::services::apache {

  include ::profile::services::apache::firewall

  class { '::apache':
    mpm_module => 'prefork',
  }

  include ::apache::mod::php
}
