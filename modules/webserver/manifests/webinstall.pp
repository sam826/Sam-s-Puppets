class webserver::webinstall {

#
# Pre-requisites
#
                package { [ 'zlib-devel', 'openssl-devel', 'readline-devel', 'ncurses-devel', 'sqlite-devel', 'curl-devel', 'pcre-devel', 'git' ]:
                        provider => yum,
                        ensure => installed
                }

                file { ["/opt/pkgs", "/opt/tools", "/opt/tools/rbmc"]:
                        ensure => 'directory',
                        mode => 0755,
                        owner => root,
                        group => root
                }

                file { ["/opt/tools/rbmc/config"]:
                        ensure => 'directory',
                        mode => 0755,
                        owner => web,
                        group => web 
                }

                Exec { path => ["/bin", "/sbin", "/usr/bin"] }


		#include webserver::curl, webserver::python
		#include webserver::pycurl, webserver::pyyaml, webserver::beautifulsoup, webserver::celery, webserver::python-daemon, webserver::pymongo, webserver::tornado, webserver::redis-py
		#include webserver::nginx, webserver::supervisor
		include webserver::supervisor

}
