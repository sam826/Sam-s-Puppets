class webserver::celery {

#		Install Celery 

		exec { "download-celery":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://pypi.python.org/packages/source/c/celery/celery-2.4.6.tar.gz",
			creates => "/opt/pkgs/celery-2.4.6.tar.gz",
		}

		exec { "extract-celery":
			cwd => "/opt/pkgs",
			command => "tar xvf celery-2.4.6.tar.gz",
			creates => "/opt/pkgs/celery-2.4.6",
			require => [ Exec["download-celery"], File["/opt/pkgs"] ],
		}

		exec { "build-celery":
			cwd => "/opt/pkgs/celery-2.4.6",
			command => "/usr/local/bin/python setup.py build",
			require => Exec["extract-celery"],
		}

		exec { "install-celery":
			cwd => "/opt/pkgs/celery-2.4.6",
			command => "/usr/local/bin/python setup.py install",
			require => Exec["build-celery"],
		}

}
