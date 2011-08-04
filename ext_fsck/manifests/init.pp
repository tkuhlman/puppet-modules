# /etc/puppet/modules/ext_fsck/manifests/init.pp

class ext_fsck {
    
    $devs = split($ext_devs, " ")

    ext_no_fsck { $devs: }
}

define ext_no_fsck() {
    exec { "tune2fs -c 0 -i 0 $name":
        unless => "tune2fs -l $name |grep -q 'Check interval:.*none' && tune2fs -l $name |grep -q 'Maximum mount count:.*-1'"
    }
}
