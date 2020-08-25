# Add users
class profile::baseconfig::users {

  $users = lookup('profile::users', false)
  if($users) {
    profile::baseconfig::createuser { $users: }
  }

  group { 'users':
    ensure => present,
    gid    => 700,
  }
}
