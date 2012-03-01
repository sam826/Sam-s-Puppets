class webserver::beautifulsoup {

#		Install BeautifulSoup

		exec { "download-beautifulsoup":
			cwd => "/opt/pkgs",
			command => "curl -L -O http://www.crummy.com/software/BeautifulSoup/download/3.x/BeautifulSoup-3.2.0.tar.gz",
			creates => "/opt/pkgs/BeautifulSoup-3.2.0.tar.gz",
		}

		exec { "extract-beautifulsoup":
			cwd => "/opt/pkgs",
			command => "tar xvf BeautifulSoup-3.2.0.tar.gz",
			creates => "/opt/pkgs/BeautifulSoup-3.2.0",
			require => [ Exec["download-beautifulsoup"], File["/opt/pkgs"] ],
		}

		exec { "install-beautifulsoup":
			cwd => "/opt/pkgs/BeautifulSoup-3.2.0",
			command => "/usr/local/bin/python setup.py install",
			require => Exec["extract-beautifulsoup"],
		}

}
