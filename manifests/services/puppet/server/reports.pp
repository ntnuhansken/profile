# Setup logrotation for puppet reports
class profile::services::puppet::server::reports {
  tidy { '/opt/puppetlabs/server/data/puppetserver/reports':
    age     => "1w",
    recurse => true,
  }
}
