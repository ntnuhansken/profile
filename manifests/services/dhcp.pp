# Installs and configures a DHCP server
class profile::services::dhcp {
  $searchdomain = lookup('profile::dhcp::searchdomain', Stdlib::Fqdn)
  $ntp_servers = lookup('profile::ntp::servers', {
    'value_type' => Array[Variant[Stdlib::Fqdn, Stdlib::IP::Address]],
    'merge'      => 'unique',
  })
  $interfaces = keys(lookup('profile::baseconfig::network::interfaces', Hash))
  $dhcp_interfaces = lookup('profile::dhcp::server::interfaces', {
    'value_type'    => Array[String],
    'default_value' => $interfaces,
  })
  $networks = lookup('profile::networks', {
    'value_type' => Array[String],
    'merge'      => 'unique',
  })

  $man_if = $facts['networking']['primary']
  $mip = $facts['networking']['interfaces'][$man_if]['ip']
  $pxe_server = lookup('profile::dhcp::pxe::server', {
    'value_type'    => Stdlib::IP::Address::V4,
    'default_value' => $mip,
  })
  $pxe_file = lookup('profile::dhcp::pxe::file', {
    'value_type'    => String,
    'default_value' => 'pxelinux.0',
  })

  $nameservers = lookup('profile::dns::resolvers', {
    'value_type' => Array[Stdlib::IP::Address::V4],
    'merge'      => 'unique',
  })

  include ::profile::services::dhcp::firewall

  class { '::dhcp':
    dnssearchdomains => [$searchdomain],
    interfaces       => $dhcp_interfaces,
    nameservers      => $nameservers,
    ntpservers       => $ntp_servers,
    pxeserver        => $pxe_server,
    pxefilename      => $pxe_file,
  }

  profile::services::dhcp::pool { $networks: }
}
