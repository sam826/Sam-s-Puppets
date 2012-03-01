class webserver::nginx {

#
# Create Web User Account
#
		
		group { "web":
                        ensure => present,
                }

		user { "web":
                        ensure => present,
                        gid => "web",
                        comment => "Web User",
                        home => "/home/web",
                        managehome => true,
                        shell => "/bin/bash",
                        password_max_age => "99999",
                        require => Group["web"],
                }

# 
# Download, extract, make and configure Nginx
#

                exec { "download-nginx-http-push":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://pushmodule.slact.net/downloads/nginx_http_push_module-0.692.tar.gz",
                        creates => "/opt/pkgs/nginx_http_push_module-0.692.tar.gz",
                }

		exec { "extract-nginx-http-push":
			cwd => "/opt/pkgs",
			command => "tar xzf nginx_http_push_module-0.692.tar.gz",
			creates => "/opt/pkgs/nginx_http_push_module-0.692",
			require => [ Exec["download-nginx-http-push"], File["/opt/pkgs"] ],
		}

		exec { "download-nginx":
                        cwd => "/opt/pkgs",
                        command => "curl -L -O http://nginx.org/download/nginx-1.0.11.tar.gz",
                        creates => "/opt/pkgs/nginx-1.0.11.tar.gz",
                }

                exec { "extract-nginx":
                        cwd => "/opt/pkgs",
                        command => "tar xzf nginx-1.0.11.tar.gz",
                        creates => "/opt/pkgs/nginx-1.0.11",
                        require => [ Exec["download-nginx"], File["/opt/pkgs"] ],
                }

		exec { "configure-nginx":
			cwd => "/opt/pkgs/nginx-1.0.11",
			command => "/opt/pkgs/nginx-1.0.11/configure --with-http_ssl_module --add-module=/opt/pkgs/nginx_http_push_module-0.692",
			# creates => "what?"
			require => Exec["extract-nginx"],
		}
	
		exec { "make-nginx":
			cwd => "/opt/pkgs/nginx-1.0.11",
			command => "/usr/bin/make",
			# creates => "what?"
			require => Exec["configure-nginx"],
		}
	
		exec { "make-install-nginx":
			cwd => "/opt/pkgs/nginx-1.0.11",
			command => "/usr/bin/make install",
			# creates => "what?"
                        require => Exec["make-nginx"],
		}

#
# Configure Nginx 
#

               	file { "/opt/tools/rbmc/config/nginx.conf":
                        source => "puppet:///modules/webserver/nginx.conf",
                #       backup => ".ORIG",
                        ensure => present,
                        mode => 0444,
                        owner => root,
                        group => root,
                        notify => Service["nginx"], # restart supervisord if changed
                        require => Exec["make-install-nginx"]
                }

                file { "/etc/init.d/nginx":
                        source => "puppet:///modules/webserver/nginx",
                        ensure => present,
                        mode => 0755,
                        owner => root,
                        group => root,
        #               notify => Service["nginx"],
                }

#
# Service: Nginx
#

                service { "nginx":
                        ensure => running,
                        enable => true, #start at boot
                        hasstatus => true,
                        hasrestart => true
                }

}
