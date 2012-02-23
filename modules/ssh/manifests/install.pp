class ssh::install {
	package {"ssh":
	  name => $operatingsystem ?
	    /(Red Hat|CentOS|Fedora|Ubuntu|Debian)/ => "openssh-server",
	    Solaris => "openssh",
	    },
	  ensure => installed,
}
