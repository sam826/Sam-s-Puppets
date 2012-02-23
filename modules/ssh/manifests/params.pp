class ssh::params {
  case $operatingsystem {
    Solaris: {
      $ssh_package_name = 'openssh'
      $ssh_service_config = '/etc/ssh/sshd_config'
    }
    /(Ubuntu|Debian)/: {
      $ssh_package_name = 'openssh-server'
      $ssh_service_config = '/etc/ssh/sshd_config'
    }
    /(RedHat|CentOS|Fedora)/: {
      $ssh_package_name = 'openssh-server'
      $ssh_service_config = '/etc/ssh/sshd_config'
    }
  }
}

