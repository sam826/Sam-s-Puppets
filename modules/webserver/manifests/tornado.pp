class webserver::tornado {

# Install Tornado

		exec { "download-tornado":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://github.com/downloads/facebook/tornado/tornado-2.2.tar.gz",
			creates => "/opt/pkgs/tornado-2.2.tar.gz",
		}

		exec { "extract-tornado":
			cwd => "/opt/pkgs",
			command => "tar xvf tornado-2.2.tar.gz",
			creates => "/opt/pkgs/tornado-2.2",
			require => [ Exec["download-tornado"], File["/opt/pkgs"] ],
		}

		exec { "install-tornado":
			cwd => "/opt/pkgs/tornado-2.2",
			command => "/usr/local/bin/python setup.py install",
			require => Exec["extract-tornado"],
		}

}
