# Installs packages

class profile::baseconfig::packages {

  $pkgs = lookup('profile::baseconfig::packages', {
    'value_type' => Array[String],
    'merge'      => 'unique',
  }

  ensure_packages($pkgs, {
    'ensure' => 'present',
  )}
}
