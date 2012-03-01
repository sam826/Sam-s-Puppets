class webserver::redis {

#
# Create Redis User Account
#

                group { "redis":
                        ensure => present,
                }

                user { "redis":
                        ensure => present,
                        gid => "redis",
                        comment => "Redis User",
                        home => "/var/redis",
                        managehome => true,
                        shell => "/bin/bash",
                        password_max_age => "99999",
                        require => Group["redis"],
                }

		file { ["/var/redis", "/var/redis/6379", "/var/log/redis"]:
                        ensure => directory,
                        mode => 0755,
                        owner => redis,
                        group => redis 
                }

                file { ["/var/log/redis/6379.log"]:
                        ensure => present,
                        mode => 0644,
                        owner => redis,
                        group => redis
		}

		file { ["/etc/redis"]:
			ensure => directory,
			mode => 0755,
			owner => root,
			group => root
		}
# 
# Download, extract, make and configure Redis 
#

                exec { "download-redis":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://redis.googlecode.com/files/redis-2.4.6.tar.gz",
                        creates => "/opt/pkgs/redis-2.4.6.tar.gz",
                }

		exec { "extract-redis":
			cwd => "/opt/pkgs",
			command => "tar xzf redis-2.4.6.tar.gz",
			creates => "/opt/pkgs/redis-2.4.6",
			require => [ Exec["download-redis"], File["/opt/pkgs"] ],
		}

		exec { "make-redis":
			cwd => "/opt/pkgs/redis-2.4.6",
			command => "/usr/bin/make",
			# creates => "what?"
			require => Exec["extract-redis"],
		}
	
		exec { "copy-redis-bin":
			cwd => "/opt/pkgs/redis-2.4.6",
			command => "/bin/cp src/redis-check-dump src/redis-check-aof src/redis-benchmark src/redis-cli /usr/local/bin",
			creates => "/usr/local/bin/redis-cli",
			require => Exec["make-redis"],
		}

		exec { "copy-redis-server":
			cwd => "/opt/pkgs/redis-2.4.6",
			command => "/bin/cp src/redis-server /usr/local/sbin",
			creates => "/usr/local/sbin/redis-server",
			require => Exec["make-redis"],
		}

		exec { "copy-redis-init-script":
			cwd => "/opt/pkgs/redis-2.4.6",
			command => "/bin/cp utils/redis_init_script /etc/init.d/redis_6379",
			creates => "/etc/init.d/redis_6379",
			require => Exec["make-redis"],
		}
	
		exec { "add-to-sysctl":
			cwd => "/etc",
			command => "/bin/echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf",
			unless => "/bin/grep -Fc 'vm.overcommit_memory' /etc/sysctl.conf"
		}

#
# Configure Redis 
#

               	file { "/etc/redis/6379.conf":
                        source => "puppet:///modules/webserver/6379.conf",
                        backup => ".ORIG",
                        ensure => present,
                        mode => 0444,
                        owner => root,
                        group => root,
                        notify => Service["redis_6379"], # restart service if changed
                }

                file { "/etc/init.d/redis_6379":
                        source => "puppet:///modules/webserver/redis_6379",
                        ensure => present,
                        mode => 0755,
                        owner => root,
                        group => root,
                        notify => Service["redis_6379"],
                }

#
# Service: Redis 
#

                service { "redis_6379":
                        ensure => running,
                        enable => true, #start at boot
                        hasstatus => true,
                        hasrestart => true
                }

}
