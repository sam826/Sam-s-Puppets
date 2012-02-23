class puppet::master {

include puppet
include puppet::params

package {"puppet-server":
  ensure => installed,
}

service {"puppetmasterd":
  ensure => running,
  hastatus => true,
  harestart => true,
  enable => true,
  require => File["/etc/puppet/puppet.conf"],
  }

}
