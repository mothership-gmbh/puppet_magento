# Init puppet provisioner for Magento installation
# puppet config print modulepath
# inspired by https://github.com/monsieurbiz/vagrant-magento
# Starting mailcatcher command "mailcatcher --http-ip `hostname -I`"

Exec {
    path => [
        '/usr/local/bin',
        '/opt/local/bin',
        '/usr/bin',
        '/usr/sbin',
        '/bin',
        '/sbin'
    ],
    logoutput => false,
}

# The server
class { "server":
    hostname      => "magento.vm"
}

# Apache
class { "apache":
    server_name   => "magento.vm",
    document_root => "/srv/magento.vm",
    logs_dir      => "/var/log/magento.vm/logs"
}

# MySQL
class { "mysql":
  root_password => "root",
  db_name => "magento",
  db_user => "root",
  db_password => "root"
}



# Includes
include php
include mailcatcher
include git
include tools