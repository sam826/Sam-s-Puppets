#
# Class mongodb::mongoinstall
#


class mongodb::mongoinstall {
#
# Package Installation
#
		file { "/etc/yum.repos.d/10gen.repo":
                        source => "puppet:///modules/mongodb/10gen.repo",
                        ensure => present,
                }
		
		exec { "/usr/bin/yum makecache":
			require => [ File["/etc/yum.repos.d/10gen.repo"]],
		}

		package { [ "mongo-10gen-server", "mongo-10gen" ]:
			provider => yum,
	  		ensure => 'present',
		}
	
		user { "mongod":
			ensure => present,
			gid => "mongod",
			comment => "mongod user",
			home => "/var/lib/mongo",
			managehome => true,
			shell => "/bin/false",
			password_max_age => "99999",
			require => Group["mongod"],
		}

		group { "mongod":
			ensure => present,
		}

#
# Configuration files
#


		file { "/etc/mongod.conf":
			ensure => present,
			mode => 0644,
			owner => root,
			group => root,
			backup => ".ORIG",
			source => "puppet:///modules/mongodb/mongod.conf",
		}
	
		file { ["/opt/MongoDB", "/opt/MongoDB/data", "/opt/MongoDB/logs", "/opt/MongoDB/scripts"]:
			ensure => 'directory',
			mode => 0755,
			owner => mongod,
			group => mongod,
		}
		
		file { "/opt/MongoDB/scripts/automongobackup":
			ensure => present,
			mode => 0744,
			owner => root,
			group => root,
			source => "puppet:///modules/mongodb/automongobackup",
		}

		file { "/etc/cron.daily/automongobackup":
			ensure => link,
			target => "/opt/MongoDB/scripts/automongobackup"
		}

#
# Mongod Service
#

		service { "mongod":
			ensure => running,
			hasstatus => true,
			hasrestart => true,
		}

}
