class webserver::python {

#		Install Python

		exec { "download-python":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://python.org/ftp/python/2.7.2/Python-2.7.2.tgz",
			creates => "/opt/pkgs/Python-2.7.2.tgz",
		}

		exec { "extract-python":
			cwd => "/opt/pkgs",
			command => "tar xvf Python-2.7.2.tgz",
			creates => "/opt/pkgs/Python-2.7.2",
			require => [ Exec["download-python"], File["/opt/pkgs"] ],
		}

		exec { "configure-python":
			cwd => "/opt/pkgs/Python-2.7.2",
			command => "/opt/pkgs/Python-2.7.2/configure",
			require => Exec["extract-python"],
		}

		exec { "make-python":
			cwd => "/opt/pkgs/Python-2.7.2",
			command => "/usr/bin/make",
			require => Exec["configure-python"],
		}

		exec { "make-install-python":
			cwd => "/opt/pkgs/Python-2.7.2",
			command => "/usr/bin/make install",
			require => Exec["make-python"],
		}


}
