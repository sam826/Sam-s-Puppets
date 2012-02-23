class puppet::service {
   service {"puppet":
     ensure => running,
     hastatus => true,
     harestart => true,
     enable => true,
     require => Class["puppet::install"],
   }
}
