# /etc/puppet/modules/tmpwatch/manifests/init.pp
# 
# NOTE: Ubuntu doesn't actually come with the tmpwatch program. However it isn't needed I just use
# find. tmpwatch and the ubuntu version tmpreaper are really to work around race conditions in find.
# These race conditions deal with setuid executables and /tmp. On systems with few users cleaning
# /tmp is sufficient on startup and I only clean up files in other dirs not associated with setuid executables.

class tmpwatch {

    #Note if the file already exists it is not replaced
    file { "/etc/cron.daily/tmpwatch":
        ensure  => present,
        owner   => "root",
        group   => "root",
        mode    => 755,
        replace => false,
        content => "#!/bin/sh\n"
    }
        
    #Realize all the defined tmpwatch dirs
    Tmpwatch_dir <| |>
}

