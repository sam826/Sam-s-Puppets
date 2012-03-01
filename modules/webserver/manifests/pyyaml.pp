class webserver::pyyaml {

#		Install Pyyaml

		exec { "download-pyyaml":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://pyyaml.org/download/pyyaml/PyYAML-3.06.tar.gz",
			creates => "/opt/pkgs/PyYAML-3.06.tar.gz",
		}

		exec { "extract-pyyaml":
			cwd => "/opt/pkgs",
			command => "tar xvf PyYAML-3.06.tar.gz",
			creates => "/opt/pkgs/PyYAML-3.06",
			require => [ Exec["download-pyyaml"], File["/opt/pkgs"] ],
		}

		exec { "install-pyyaml":
			cwd => "/opt/pkgs/PyYAML-3.06",
			command => "/usr/local/bin/python setup.py install",
			require => Exec["extract-pyyaml"],
		}

}
