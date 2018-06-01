#!/bin/bash
# echo '*/2 * * * * root bash /root/freeram.sh' >> /etc/crontab
run=`netstat -lntup|grep 8083`; if [ "$run" = "" ]; then service vesta restart; fi
freemem=$(free -m | awk '/Mem:/{print $4}')
(( freemem <= 100 )) && service httpd reload
