# Puppetserver
class profile::services::puppet::server {
  include ::profile::services::puppet::server::firewall
  include ::profile::services::puppet::server::service
  include ::profile::services::puppet::server::reports
}
