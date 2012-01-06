# Allows configuring of sysctl.conf and on refresh loading of it.
# largely based on http://projects.puppetlabs.com/projects/1/wiki/Puppet_Augeas#/etc/sysctl.conf

define sysctl ( $value ) {
    $context = "/files/etc/sysctl.conf"
    $key = $name

    augeas { "sysctl_conf/$key":
        context => "$context",
        onlyif  => "get $key != '$value'",
        changes => "set $key '$value'",
        notify  => Exec["sysctl $key"],
    }

    exec { "sysctl $key":
        command     => 'sysctl -p',
        refreshonly => true,
    }
}
