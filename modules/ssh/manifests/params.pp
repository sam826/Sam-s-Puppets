class ssh::params {
  case $operatingsystem {
    Solaris: {
      $ssh_package_name = 'openssh'
    }
    /(Ubuntu|Debian)/: {
      $ssh_package_name = 'openssh-server'
    }
    /(RedHat|CentOS|Fedora)/: {
      $ssh_package_name = 'openssh-server'
    }
  }
}

