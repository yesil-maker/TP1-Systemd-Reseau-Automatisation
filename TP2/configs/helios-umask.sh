if id -nG | tr ' ' '\n' | grep -qx transport ; then umask 002 ; else umask 027 ; fi
