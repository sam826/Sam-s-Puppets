class webserver::redis-py {

#		Install Redis-py

		exec { "download-redis-py":
			cwd => "/opt/pkgs",
			command => "curl -L -O https://github.com/downloads/andymccurdy/redis-py/redis-2.4.11.tar.gz",
			creates => "/opt/pkgs/redis-2.4.11.tar.gz",
		}

		exec { "extract-redis-py":
			cwd => "/opt/pkgs",
			command => "tar xvf redis-2.4.11.tar.gz",
			creates => "/opt/pkgs/redis-2.4.11",
			require => [ Exec["download-redis-py"], File["/opt/pkgs"] ],
		}

		exec { "install-redis-py":
			cwd => "/opt/pkgs/redis-2.4.11",
			command => "/usr/local/bin/python setup.py install",
			require => Exec["extract-redis-py"],
		}

}
