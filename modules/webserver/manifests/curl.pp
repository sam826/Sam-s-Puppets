class webserver::curl {

#		Install Curl

                exec { "download-curl":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://curl.haxx.se/download/curl-7.24.0.tar.gz",
                        creates => "/opt/pkgs/curl-7.24.0.tar.gz",
                }

		exec { "extract-curl":
			cwd => "/opt/pkgs",
			command => "tar xzf curl-7.24.0.tar.gz",
			creates => "/opt/pkgs/curl-7.24.0",
			require => [ Exec["download-curl"], File["/opt/pkgs"] ],
		}

		exec { "configure-curl":
			cwd => "/opt/pkgs/curl-7.24.0",
			command => "/opt/pkgs/curl-7.24.0/configure",
			# creates => "what?"
			require => Exec["extract-curl"],
		}
	
		exec { "make-curl":
			cwd => "/opt/pkgs/curl-7.24.0",
			command => "/usr/bin/make",
			# creates => "what?"
			require => Exec["configure-curl"],
		}
	
		exec { "make-install-curl":
			cwd => "/opt/pkgs/curl-7.24.0",
			command => "/usr/bin/make install",
			# creates => "what?"
                        require => Exec["make-curl"],
		}

		exec { "link-new-curl-lib":
			cwd => "/opt/pkgs/curl-7.24.0",
			command => "ldconfig -c new /usr/local/lib/libcurl.so.4",
			# creates => "what?"
                        require => [ Exec["make-install-curl"] ],
		}		

}
