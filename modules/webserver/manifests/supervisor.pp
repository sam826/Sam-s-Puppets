class webserver::supervisor {

#
# Install Supervisor 
#

		exec { "download-supervisor":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://pypi.python.org/packages/source/s/supervisor/supervisor-3.0a12.tar.gz",
			creates => "/opt/pkgs/supervisor-3.0a12.tar.gz",
		}

		exec { "extract-supervisor":
			cwd => "/opt/pkgs",
			command => "tar xvf supervisor-3.0a12.tar.gz",
			creates => "/opt/pkgs/supervisor-3.0a12",
			require => [ Exec["download-supervisor"], File["/opt/pkgs"] ],
		}

		exec { "install-supervisor":
			cwd => "/opt/pkgs/supervisor-3.0a12",
			command => "/usr/local/bin/python setup.py install",
			require => Exec["extract-supervisor"],
		}

#
# Configure Supervisor
#

		file { "/opt/tools/rbmc/config/supervisord.conf":
			source => "puppet:///modules/webserver/supervisord.conf",
		#	backup => ".ORIG",
			ensure => present,
			mode => 0444,
			owner => root,
			group => root,
			notify => Service["supervisord"], # restart supervisord if changed
			require => Exec["install-supervisor"]
		}
			
		file { "/etc/init.d/supervisord":
			source => "puppet:///modules/webserver/supervisord",
			ensure => present,
			mode => 0755,
			owner => root,
			group => root,
	#		notify => Service["supervisord"], 
		}

#
# Supervisor Service
#

		service { "supervisord":
			ensure => running,
			enable => true, #start at boot
			hasstatus => true,
			hasrestart => true
		}
		
}
