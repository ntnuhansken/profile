# This class installs and configures NTP and timezone
class profile::baseconfig::time {
  $ntpservers = hiera('profile::ntp::servers')
  $tz = lookup('profile::ntp::timezone', {
    'value_type'    => String,
    'default_value' => 'Europe/Oslo'
  })

  class { '::ntp':
    servers  => $ntpservers,
    restrict => [
      '127.0.0.1',
      '-6 ::1',
      'default kod nomodify notrap nopeer noquery',
      '-6 default kod nomodify notrap nopeer noquery',
    ],
  }

  file {'/etc/localtime':
    ensure => link,
    target => "/usr/share/zoneinfo/${tz}"
  }
}
