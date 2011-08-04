# This definition is used throughout my modules as a virtual resource for anything needing an iptables rule
# The module iptables then realizes the virtual instances of it.

define iptables_rule($content){ #The name is best prefixed with a 2 digit number to preserver order
    file { "/etc/iptables.d/$name":
        content => "$content\n",
        notify  => Service['iptables'],
        mode    => 644,
    }
}
