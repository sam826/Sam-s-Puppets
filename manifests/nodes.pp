class base {
  include ssh, puppet
}

node 'vm-pc-ub-1.nyc.rr.com'{
	include base
	include puppet::master
}

node 'vm-pc-ub-2.nyc.rr.com'{
	include base
	include apache

	apache::vhost { 'www.example.com':
	  port => 80,
	  docroot => '/var/www/www.example.com',
	  ssl => false,
	  priority => 10,
	  serveraliases => 'home.example.com',
	}

	apache::vhost { 'another.example.com':
	  port => 80,
	  docroot => '/var/www/another.example.com',
	  ssl => false,
	  priority => 10,
	}
}

node 'vm-pc-ub-3.nyc.rr.com'{
	include base
}

