class webserver::pycurl {

#		Install Pycurl

		exec { "download-pycurl":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://pycurl.sourceforge.net/download/pycurl-7.19.0.tar.gz",
			creates => "/opt/pkgs/pycurl-7.19.0.tar.gz",
		}

		exec { "extract-pycurl":
			cwd => "/opt/pkgs",
			command => "tar xvf pycurl-7.19.0.tar.gz",
			creates => "/opt/pkgs/pycurl-7.19.0",
			require => [ Exec["download-pycurl"], File["/opt/pkgs"] ],
		}

		exec { "install-pycurl":
			cwd => "/opt/pkgs/pycurl-7.19.0",
			command => "/usr/local/bin/python setup.py install",
			require => Exec["extract-pycurl"],
		}

}
