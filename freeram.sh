#!/bin/bash
# echo '*/2 * * * * root bash /root/freeram.sh' >> /etc/crontab
PATH=/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/bin
source ~/.bashrc  >/dev/null 2>&1
source ~/.bash_profile  >/dev/null 2>&1
run=`netstat -lntup|grep 8083`; if [ "$run" = "" ]; then service vesta restart; fi
run=`netstat -lntup|grep 8080`; if [ "$run" = "" ]; then service httpd restart; fi
run=`netstat -lntup|grep 3306`; if [ "$run" = "" ]; then service mysql restart; fi
RAMsar=`sar -r  1 1 | grep Average:`
used=`echo "$RAMsar" | awk '{print $3}'| tr . ' ' | awk '{print $1}'`
buffer=`echo "$RAMsar" | awk '{print $5}'| tr . ' ' | awk '{print $1}'`
cached=`echo "$RAMsar" | awk '{print $6}'| tr . ' ' | awk '{print $1}'`
RAMdangdung=$(((used-buffer-cached)/1024)) ;
RAMtong=$(free -m | awk '/Mem:/{print $2}') ;
RAMconlai=$((RAMtong-RAMdangdung));
(( RAMdangdung <= 100 )) && service httpd restart && service varnish restart && service mysql restart && sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"
