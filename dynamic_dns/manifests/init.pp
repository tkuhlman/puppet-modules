# Setup a startup task to update the dynamic dns with the proper cname
# This will only work for ec2 machines at this point.
# The cname is updated so the address works inside or outside
# This relies on our aws dev account and a route 53 ec2 subdomain setup with that account.
# When AWS Identity and Access Management is mature I should make a new account for this.

class dynamic_dns {

    package { 'python-cirrus': }
    file { "/etc/init.d/dns_update":
        mode    => 700,
        owner   => root,
        group   => root,
        content => template("dynamic_dns/dns_update.erb"),
        notify  => Exec["update-rc.d dns_update defaults"],
    }
    exec { "update-rc.d dns_update defaults":
        refreshonly => true,
    }

    #Setup dhcp to use our domain name
    exec { "dhcp_domainname":
        command => "/bin/echo -e \'supersede domain-name \"$domain ec2.internal compute-1.internal\";\' >> /etc/dhcp3/dhclient.conf",
        unless  => "/bin/grep -q $domain /etc/dhcp3/dhclient.conf",
    }
}
