# This definition is used throughout my modules as a virtual resource for anything needing tmpwatch to run.
# The module tmpwatch then realizes the virtual instances of it.

define tmpwatch_dir($dir, $days, $custom=""){
    #Always do depth first searching so rm -r isn't run twice on some paths
    #Always do -mindepth 1 because I don't want the dir I am checking to be deleted when empty
    exec { "echo 'find $dir -mindepth 1 -depth -mtime +$days $custom -exec rm -r {} \\;' >> /etc/cron.daily/tmpwatch":
        unless  => "grep -q 'find $dir ' /etc/cron.daily/tmpwatch",
        require => File['/etc/cron.daily/tmpwatch'],
    }
}
