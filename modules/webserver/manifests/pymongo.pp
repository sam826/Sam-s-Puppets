class webserver::pymongo {

#		Install Pymongo

		exec { "download-pymongo":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://pypi.python.org/packages/source/p/pymongo/pymongo-1.11.tar.gz",
			creates => "/opt/pkgs/pymongo-1.11.tar.gz",
		}

		exec { "extract-pymongo":
			cwd => "/opt/pkgs",
			command => "tar xvf pymongo-1.11.tar.gz",
			creates => "/opt/pkgs/pymongo-1.11",
			require => [ Exec["download-pymongo"], File["/opt/pkgs"] ],
		}

		exec { "install-pymongo":
			cwd => "/opt/pkgs/pymongo-1.11",
			command => "/usr/local/bin/python setup.py install",
			require => Exec["extract-pymongo"],
		}

}
