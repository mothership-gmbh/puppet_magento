class apache::install ( $server_name, $document_root, $logs_dir ) {

    Exec {
        path => [
            '/usr/local/bin',
            '/opt/local/bin',
            '/usr/bin',
            '/usr/sbin',
            '/bin',
            '/sbin'
        ],
    }

    # Install the package
    package { "apache2":
        name => "apache2",
        ensure => latest
    }

    # create a directory
    file { "/var/log/$server_name":
         ensure => "directory",
         owner  => "root",
         group  => "root",
         mode   => 777,
    }

     # create a directory
     file { "/var/log/$server_name/logs":
         ensure => "directory",
         owner  => "root",
         group  => "root",
         mode   => 777,
     }

    # The virtualhost file
    -> file {'virtual-host-file':
        path    => "/etc/apache2/sites-available/$server_name",
        ensure  => present,
        content => template("apache/magento.vhost"),
        notify  => Class['apache::service'],
    }

    # Enable the virtualhost
    exec { "Enable the virtualhost":
        command => "a2ensite $server_name",
        creates => "/etc/apache2/sites-enabled/$server_name",
        require => [ Package['apache2'], File['virtual-host-file'] ],
        notify => Class['apache::service'],
    }

     # Set the host in local loop
    host { "magento":
        ensure => present,
        ip => "127.0.0.1",
        name => $server_name,
    }

     # Mods
    exec { 'enable mod rewrite':
        onlyif => 'test `apache2ctl -M 2> /dev/null | grep rewrite | wc -l` -ne 1',
        command => 'a2enmod rewrite',
        require => Package['apache2'],
    } ~> Service['apache2']
}