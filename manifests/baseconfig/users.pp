# Add users
class profile::baseconfig::users {

  $users = lookup('profile::users', {
    'value_type'    => Variant[Array[String], Boolean],
    'default_value' => false,
  })

  if($users) {
    profile::baseconfig::createuser { $users: }
  }

  group { 'users':
    ensure => present,
    gid    => 700,
  }
}
