# Create users
class profile::baseconfig::users {
  $users = lookup('profile::users', {
    'value_type'    => Variant[Hash, Boolean],
    'default_value' => false
  })

  group { 'users':
    ensure => present,
    gid    => 700,
  }

  if($users) {
    $users.each | $user, $data | {
      if($data['ensure']) { $ensure = $data['ensure'] }
      else                { $ensure = 'present' }

      user { $user:
        ensure         => $ensure,
        gid            => 'users',
        groups         => $data['groups'],
        home           => "/home/${user}",
        managehome     => true,
        password       => $data['hash'],
        purge_ssh_keys => true,
        require        => Group['users'],
        shell          => '/bin/bash',
        uid            => $data['uid'],
      }

      if($ensure == 'present') {
        file { "/home/${user}/.ssh":
          ensure  => 'directory',
          owner   => $user,
          group   => 'users',
          mode    => '0700',
          require => User[$user],
        }
      }

      if($data['ssh-keys']) {
        $data['ssh-keys'].each | $keyname, $key_data | {
          ssh_authorized_key { $keyname:
            user    => $user,
            type    => $key_data['type'],
            key     => $key_data['key'],
            require => File["/home/${user}/.ssh"],
          }
        }
      }
    }
  }
}
