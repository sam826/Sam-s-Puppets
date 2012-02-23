class apache::service {
  service {"apache2":
    ensure => running,
    hastatus => true,
    harestart => true,
    enable => true,
    require => Class["apache::install"],
  }
}
