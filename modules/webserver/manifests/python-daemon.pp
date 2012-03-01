class webserver::python-daemon {

#		Install Python-daemon

		exec { "download-python-daemon":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://pypi.python.org/packages/source/p/python-daemon/python-daemon-1.5.5.tar.gz",
			creates => "/opt/pkgs/python-daemon-1.5.5.tar.gz",
		}

		exec { "extract-python-daemon":
			cwd => "/opt/pkgs",
			command => "tar xvf python-daemon-1.5.5.tar.gz",
			creates => "/opt/pkgs/python-daemon-1.5.5",
			require => [ Exec["download-python-daemon"], File["/opt/pkgs"] ],
		}

		exec { "install-python-daemon":
			cwd => "/opt/pkgs/python-daemon-1.5.5",
			command => "/usr/local/bin/python setup.py install",
			require => Exec["extract-python-daemon"],
		}

}
