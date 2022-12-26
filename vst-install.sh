#!/bin/bash
# Vesta installation wrapper
# http://vestacp.com

#
# Currently Supported Operating Systems:
#
#   RHEL 5, RHEL 6
#   CentOS 5, CentOS 6
#   Debian 7
#   Ubuntu LTS, Ubuntu 13.04, Ubuntu 13.10
#

# Am I root?
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

# Check admin user account
if [ ! -z "$(grep ^admin: /etc/passwd)" ] && [ -z "$1" ]; then
    echo "Error: user admin exists"
    echo
    echo 'Please remove admin user account before proceeding.'
    echo 'If you want to do it automatically run installer with -f option:'
    echo "Example: bash $0 --force"
    exit 1
fi

# Check admin user account
if [ ! -z "$(grep ^admin: /etc/group)" ] && [ -z "$1" ]; then
    echo "Error: group admin exists"
    echo
    echo 'Please remove admin user account before proceeding.'
    echo 'If you want to do it automatically run installer with -f option:'
    echo "Example: bash $0 --force"
    exit 1
fi

# Detect OS
case $(head -n1 /etc/issue | cut -f 1 -d ' ') in
    Debian)     type="debian" ;;
    Ubuntu)     type="ubuntu" ;;
    *)          type="rhel" ;;
esac


# Check curl
if [ -e '/usr/bin/curl' ]; then
    curl -O http://vestacp.com/pub/vst-install-$type.sh
    if [ "$?" -eq '0' ]; then
        echo '      sed -i "s/php54/php%PHP_Server_version%/g" /etc/yum.repos.d/remi.repo
        sed -i "s/php55/php%PHP_Server_version%/g" /etc/yum.repos.d/remi.repo
        sed -i "s/php56/php%PHP_Server_version%/g" /etc/yum.repos.d/remi.repo' > tmp.txt
        sed -i '/remi.repo/r tmp.txt' vst-install-$type.sh
        rm -f tmp.txt
        d='vesta,remi*'; c='vesta,remi,remi-php%PHP_Server_version%,mariadb'
        sed -i "s#$d#$c#g" vst-install-$type.sh
        remove81="remi-php81.repo"
        sed -i "/.*$remove81.*/d" vst-install-$type.sh
        MariaDB_Server_version='%MariaDB_Server_version%'
        if [ "$MariaDB_Server_version" != "5.5" ]; then
            d='mariadb mariadb-server'; c='MariaDB-server MariaDB-client'
            sed -i "s#$d#$c#g" vst-install-$type.sh
        fi
        bash vst-install-$type.sh $*
        exit
    else
        echo "Error: vst-install-$type.sh download failed."
        exit 1
    fi
fi

exit

