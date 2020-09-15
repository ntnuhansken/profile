# Install a mysql server
class profile::services::mysql {

  include ::profile::services::mysql::firewall

  $root_pw = lookup('profile::mysql::root_password', String)

  class { '::mysql::server':
    root_password           => $root_pw,
    restart                 => true,
    remove_default_accounts => true,
  }
}
