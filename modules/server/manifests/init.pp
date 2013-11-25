class server ( $hostname ) {

    exec { "update":
        path    => "/bin:/usr/bin",
        command => "apt-get update",
    }

    $packages = ["curl", "tidy"]
    package { $packages:
        ensure  => latest,
        require => Exec['update'],
    }
}