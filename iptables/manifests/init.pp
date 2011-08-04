# /etc/puppet/modules/iptables/manifests/init.pp
#
# The iptables class sets up a simple iptables init script and creates an iptables-save file
# At this point it assumes only the default filter table

class iptables {
    File {
        mode    => 600,
        owner   => root,
        group   => root,
        ensure  => present,
    }

    package { "iptables": }
    file { "/etc/init.d/iptables":
        mode    => 755,
        source  => "puppet:///modules/iptables/iptables-init",
        notify  => Exec["update-rc.d iptables defaults"],
    }
    exec { "update-rc.d iptables defaults":
        refreshonly => true,
    }
    service { "iptables": }

    #Setup the base rules
    file { "/etc/iptables.d":
        ensure  => directory,
    }
    file {
        "/etc/iptables.d/00header":
            source  => "puppet:///modules/iptables/header",
            notify  => Service['iptables'],
            require => File['/etc/iptables.d'];
        "/etc/iptables.d/99footer":
            source  => "puppet:///modules/iptables/footer",
            notify  => Service['iptables'],
            require => File['/etc/iptables.d'];
    }
    #Realize all the defined iptables rules
    Iptables_rule <| |>

    file {"ip6tables":
        path    => "/etc/network/ip6tables",
        source  => "puppet:///modules/iptables/ip6tables",
        notify  => Service['iptables'],
    }
    
}
