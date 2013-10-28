class mailcatcher () {

    $modules = [
        "ruby",
        "rubygems",
    ]
    package { $modules :
        ensure => latest,
        require => Exec["update"],
      }

    package { "mailcatcher":
        ensure => latest,
        provider => gem,
        require => [ Class["php"], Class['apache'] ],
        notify => Service["apache2"],
    }

}