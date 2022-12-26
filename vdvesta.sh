#!/bin/bash


if [ $(id -u) != "0" ]; then
echo 'ERROR! Please su root and try again!
'
exit 0
fi


os=$(cut -f 1 -d ' ' /etc/redhat-release)
release=$(grep -o "[0-9]" /etc/redhat-release |head -n1)
arch=`arch`
random=`cat /dev/urandom | tr -cd 'A-Z0-9' | head -c 5`
password=`cat /dev/urandom | tr -cd 'A-Z0-9' | head -c 10`
IP=`curl -s -L http://cpanel.net/showip.cgi`
if [ ! -f /etc/redhat-release ] || [ "$os" != "CentOS" ] || [ "$release" != "7" ]; then
echo 'ERROR! Please use CentOS Linux release 7 x86_64!
'
exit 0
fi

clear
############################################################
echo '	Welcome to VDVESTA:
A shell script auto Custom & Install VESTACP for your CentOS Server Release 7 x86_64.
								Thanks you for using!
'

vDDoS_yn=''; Varnish_yn=''; File_Manager_yn=''; Zend_opcode_yn=''; Memcached_yn=''; Limit_Hosting_yn='';
Kernel_limit_DDOS_yn=''; change_port_yn=''; Web_Server_version=''; PHP_Server_version='';
auto_config_PHP_yn=''; MariaDB_Server_version=''; Spamassassin_Clamav_yn=''; fail2ban_yn='';


echo '
 LAMP5: Apache + PHP 5.4 + MariaDB 5.5
 LAMP7: Apache + PHP 7.4 + MariaDB 10.5
 LAMP8: Apache + PHP 8.0 + MariaDB 10.5

 LEMP7: Nginx + PHP 7.4 + MariaDB 10.5
 LEMP8: Nginx + PHP 8.0 + MariaDB 10.5
'
echo -n 'Which Web Server version you want to install [lamp5|lamp7|lemp7|lamp8|lemp8]: '
read software_all
if [ "$software_all" != "lamp5" ] && [ "$software_all" != "lamp7" ] && [ "$software_all" != "lemp7" ] && [ "$software_all" != "lamp8" ] && [ "$software_all" != "lemp8" ]; then
software_all=lamp7
fi
echo 'Web Server version install => '$software_all''


echo -n 'Would you like +install vDDoS Proxy Protection [Y|n]: '
read vDDoS_yn
if [ "$vDDoS_yn" != "y" ] && [ "$vDDoS_yn" != "n" ]; then
vDDoS_yn=y
fi
echo 'vDDoS Proxy Protection install => '$vDDoS_yn''

if [ "$vDDoS_yn" = "y" ]; then
echo -n 'Would you like +install Varnish Cache [Y|n]: '
read Varnish_yn
if [ "$Varnish_yn" != "y" ] && [ "$Varnish_yn" != "n" ]; then
Varnish_yn=y
fi
echo 'Varnish Proxy Server install => '$Varnish_yn''
fi

echo -n 'Would you like auto config PHP [Y|n]: '
read auto_config_PHP_yn
if [ "$auto_config_PHP_yn" != "y" ] && [ "$auto_config_PHP_yn" != "n" ]; then
auto_config_PHP_yn=y
fi
echo 'Auto config PHP => '$auto_config_PHP_yn''

echo -n 'Would you like +install File Manager [Y|n]: '
read File_Manager_yn
if [ "$File_Manager_yn" != "y" ] && [ "$File_Manager_yn" != "n" ]; then
File_Manager_yn=y
fi
echo 'File Manager install => '$File_Manager_yn''

echo -n 'Would you like +install Zend optimize plus opcode cache [Y|n]: '
read Zend_opcode_yn
if [ "$Zend_opcode_yn" != "y" ] && [ "$Zend_opcode_yn" != "n" ]; then
Zend_opcode_yn=y
fi
echo 'Zend Opcode Cache install => '$Zend_opcode_yn''


echo -n 'Would you like +install Memcached [Y|n]: '
read Memcached_yn
if [ "$Memcached_yn" != "y" ] && [ "$Memcached_yn" != "n" ]; then
Memcached_yn=y
fi
echo 'Memcached install => '$Memcached_yn''

echo -n 'Would you like +install Limit Hosting (limit CPU, RAM, IO your hosting account) [Y|n]: '
read Limit_Hosting_yn
if [ "$Limit_Hosting_yn" != "y" ] && [ "$Limit_Hosting_yn" != "n" ]; then
Limit_Hosting_yn=y
fi
echo 'Limit Hosting install => '$Limit_Hosting_yn''

echo -n 'Would you like Configure Kernel limit DDOS [Y|n]: '
read Kernel_limit_DDOS_yn
if [ "$Kernel_limit_DDOS_yn" != "y" ] && [ "$Kernel_limit_DDOS_yn" != "n" ]; then
Kernel_limit_DDOS_yn=y
fi
echo 'Kernel limit DDOS => '$Kernel_limit_DDOS_yn''

echo -n 'Would you like change port VestaCP 8083 to 2083 [Y|n]: '
read change_port_yn
if [ "$change_port_yn" != "y" ] && [ "$change_port_yn" != "n" ]; then
change_port_yn=y
fi
echo 'Change port VestaCP 8083 to 2083 => '$change_port_yn''



echo -n 'Would you like +install Spamassassin & Clamav [y|N]: '
read Spamassassin_Clamav_yn
if [ "$Spamassassin_Clamav_yn" != "y" ] && [ "$Spamassassin_Clamav_yn" != "Y" ]; then
Spamassassin_Clamav_yn=n
fi
echo 'Install Spamassassin & Clamav => '$Spamassassin_Clamav_yn''

echo -n 'Would you like +install Fail2ban [y|N]: '
read fail2ban_yn
if [ "$fail2ban_yn" != "y" ] && [ "$fail2ban_yn" != "Y" ]; then
fail2ban_yn=n
fi
echo 'Install Fail2ban => '$fail2ban_yn''

hostname_set="vdvesta.`hostname -f`.local"
echo -n 'Enter your hostname ['$hostname_set']: '
read hostname_i
if [ "$hostname_i" = "" ]; then
hostname_i=$hostname_set
fi
if [ ! -f /usr/bin/nslookup ]; then
yum -y install bind-utils  >/dev/null 2>&1
fi
IP_hostname=`nslookup $hostname_i 8.8.4.4| awk '/^Address: / { print $2 }'`
if [ "$IP_hostname" = "" ]; then
IP_hostname='UNKNOWN'
fi
if [ "$IP_hostname" != "$IP" ]; then
echo 'ERROR! 
Your Server IP Address is ==> '$IP'!
Your Hostname '$hostname_i' point to IP Address ==> '$IP_hostname'!

Please point your Domain DNS A record '$hostname_i' to '$IP' and try again!'
exit 0
fi

echo 'Hostname => '$hostname_i''
hostnamectl set-hostname $hostname_i

echo -n 'Enter your Email [admin@'$hostname_i']: '
read email_i
if [ "$email_i" = "" ]; then
email_i='admin@'$hostname_i''
fi
echo 'Email => '$email_i''
echo 'timeout=60' >> /etc/yum.conf
yum -y update
yum -y install yum-utils >/dev/null 2>&1
yum -y install e2fsprogs nano screen wget curl zip unzip net-tools nano screen wget curl zip unzip net-tools which psmisc htop sysstat e2fsprogs >/dev/null 2>&1
yum -y remove httpd* php* mysql* >/dev/null 2>&1

#############################################################

# lamp5: PHP 5.4 + MariaDB 5.5
if [ "$software_all" = "lamp5" ]; then
Web_Server_version=apache
PHP_Server_version=54
MariaDB_Server_version='5.5'
Remi_yn='--remi no'
PHP_Selector_yn='n'
fi

# lamp7: PHP 7.4 + MariaDB 10.5
if [ "$software_all" = "lamp7" ]; then
Web_Server_version=apache
PHP_Server_version=74
MariaDB_Server_version='10.5'
Remi_yn='--remi yes'
PHP_Selector_yn='y'
fi
# lemp7: PHP 7.4 + MariaDB 10.5
if [ "$software_all" = "lemp7" ]; then
Web_Server_version=nginx
PHP_Server_version=74
MariaDB_Server_version='10.5'
Remi_yn='--remi yes'
PHP_Selector_yn='n'
fi



# lamp8: PHP 8.0 + MariaDB 10.5
if [ "$software_all" = "lamp8" ]; then
Web_Server_version=apache
PHP_Server_version=80
MariaDB_Server_version='10.5'
Remi_yn='--remi yes'
PHP_Selector_yn='y'
fi
# lemp8: PHP 8.0 + MariaDB 10.5
if [ "$software_all" = "lemp8" ]; then
Web_Server_version=nginx
PHP_Server_version=80
MariaDB_Server_version='10.5'
Remi_yn='--remi yes'
PHP_Selector_yn='n'
fi


if [ "$MariaDB_Server_version" != "5.5" ]; then
echo '# MariaDB '$MariaDB_Server_version' CentOS repository list - created 2021-01-17 09:08 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = https://download.nus.edu.sg/mirror/mariadb/yum/'$MariaDB_Server_version'/centos7-amd64
gpgkey=https://download.nus.edu.sg/mirror/mariadb/yum/RPM-GPG-KEY-MariaDB
gpgcheck=1' > /etc/yum.repos.d/MariaDB.repo
fi




xfs_yn=`cat /etc/fstab |grep xfs`
if [ "$xfs_yn" == "" ]; then
xfs_yn=n
fi

############################################################

#curl -O http://vestacp.com/pub/vst-install.sh
wget https://raw.githubusercontent.com/duy13/VDVESTA/master/vst-install.sh

d='%PHP_Server_version%'; c="$PHP_Server_version"
sed -i "s#$d#$c#g" vst-install.sh
d='%MariaDB_Server_version%'; c="$MariaDB_Server_version"
sed -i "s#$d#$c#g" vst-install.sh


if [ "$Web_Server_version" = "apache" ]; then
Web_Server_version='--nginx no --apache yes --phpfpm no'
fi
if [ "$Web_Server_version" = "nginx" ]; then
Web_Server_version='--nginx yes --apache no --phpfpm yes'
PHP_Selector_yn=n
fi
if [ "$Spamassassin_Clamav_yn" = "y" ]; then
Spamassassin_Clamav_yn='--spamassassin yes --clamav yes'
fi
if [ "$Spamassassin_Clamav_yn" = "n" ]; then
Spamassassin_Clamav_yn='--spamassassin no --clamav no'
fi
if [ "$fail2ban_yn" = "y" ]; then
fail2ban_yn='--fail2ban yes'
fi
if [ "$fail2ban_yn" = "n" ]; then
fail2ban_yn='--fail2ban no'
fi
if [ "$xfs_yn" != "n" ]; then
quota_yn='--quota no'
cp /etc/fstab /etc/fstab.bak.$random
fi
if [ "$xfs_yn" = "n" ]; then
quota_yn='--quota yes'
fi
if [ "$Web_Server_version" = "apache" ]; then
Web_Server_version='--nginx no --apache yes --phpfpm no'
fi


sed -i '/enabled=0/a skip_if_unavailable=1' /etc/yum.repos.d/CentOS-Vault.repo
bash vst-install.sh --force --interactive yes $Web_Server_version --vsftpd yes --proftpd no --exim yes --dovecot yes $Spamassassin_Clamav_yn --named yes --iptables yes $fail2ban_yn --softaculous no --mysql yes --postgresql no $Remi_yn $quota_yn --hostname $hostname_i --email $email_i --password $password



if [ "$vDDoS_yn" != "y" ]; then
yum -y install socat
wget -O -  https://get.acme.sh | sh
/root/.acme.sh/acme.sh --set-default-ca  --server  letsencrypt >/dev/null 2>&1
echo '@monthly root sleep 10 && service vesta restart' | sudo tee --append /etc/crontab  >/dev/null 2>&1
service httpd restart >/dev/null 2>&1
service nginx restart >/dev/null 2>&1
/root/.acme.sh/acme.sh --issue -d $hostname_i -w /home/admin/web/$hostname_i/public_html
if [ -f /root/.acme.sh/$hostname_i/fullchain.cer ]; then
rm -rf /usr/local/vesta/ssl/*

cp -r /root/.acme.sh/$hostname_i/fullchain.cer /usr/local/vesta/ssl/certificate.crt
cp -r /root/.acme.sh/$hostname_i/$hostname_i.key /usr/local/vesta/ssl/certificate.key
chmod -R 664 /usr/local/vesta/ssl/*
service vesta restart

fi
fi


# lamp5: PHP 5.4 + MariaDB 5.5
if [ "$software_all" = "lamp5" ]; then
if [ "$Zend_opcode_yn" = "y" ]; then
yum -y --enablerepo=remi* install  php-opcache
fi

if [ "$Memcached_yn" = "y" ]; then
yum -y --enablerepo=remi* install php-pecl-memcached php-pecl-memcache memcached php-memcached 
service memcached start
chkconfig memcached on
fi
fi

# lamp7,lemp7...
if [ "$software_all" != "lamp5" ]; then
if [ "$Zend_opcode_yn" = "y" ]; then
yum -y --enablerepo=--enablerepo=remi,remi-php$PHP_Server_version install  php-opcache
fi

if [ "$Memcached_yn" = "y" ]; then
yum -y --enablerepo=--enablerepo=remi,remi-php$PHP_Server_version install php-pecl-memcached php-pecl-memcache memcached php-memcached redis php-pecl-redis
service memcached start
chkconfig memcached on
chkconfig redis on
service redis start
fi
fi



if [ "$Limit_Hosting_yn" = "y" ]; then
yum -y install libcgroup
yum -y install libcgroup-pam
echo "session         optional        pam_cgroup.so" >> /etc/pam.d/su
curl -L https://raw.githubusercontent.com/duy13/VDVESTA/master/Limit-Hosting -o /usr/bin/Limit-Hosting
goc=`curl -L https://raw.githubusercontent.com/duy13/VDVESTA/master/md5sum.txt --silent | grep "Limit-Hosting" |awk 'NR==1 {print $1}'`
tai=`md5sum /usr/bin/Limit-Hosting | awk 'NR==1 {print $1}'`
if [ "$goc" != "$tai" ]; then
curl -L http://1.voduy.com/VDVESTA/Limit-Hosting -o /usr/bin/Limit-Hosting
fi
chmod 700 /usr/bin/Limit-Hosting

fi

if [ "$Kernel_limit_DDOS_yn" = "y" ]; then
cp /etc/sysctl.conf /etc/sysctl.conf.bak.$random
echo 'kernel.printk = 4 4 1 7
kernel.panic = 10
kernel.sysrq = 0
kernel.shmmax = 4294967296
kernel.shmall = 4194304
kernel.core_uses_pid = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
vm.swappiness = 20
vm.dirty_ratio = 80
vm.dirty_background_ratio = 5
fs.file-max = 2097152
net.core.netdev_max_backlog = 262144
net.core.rmem_default = 31457280
net.core.rmem_max = 67108864
net.core.wmem_default = 31457280
net.core.wmem_max = 67108864
net.core.somaxconn = 65535
net.core.optmem_max = 25165824
net.ipv4.neigh.default.gc_thresh1 = 4096
net.ipv4.neigh.default.gc_thresh2 = 8192
net.ipv4.neigh.default.gc_thresh3 = 16384
net.ipv4.neigh.default.gc_interval = 5
net.ipv4.neigh.default.gc_stale_time = 120
net.netfilter.nf_conntrack_max = 10000000
net.netfilter.nf_conntrack_tcp_loose = 0
net.netfilter.nf_conntrack_tcp_timeout_established = 1800
net.netfilter.nf_conntrack_tcp_timeout_close = 10
net.netfilter.nf_conntrack_tcp_timeout_close_wait = 10
net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 20
net.netfilter.nf_conntrack_tcp_timeout_last_ack = 20
net.netfilter.nf_conntrack_tcp_timeout_syn_recv = 20
net.netfilter.nf_conntrack_tcp_timeout_syn_sent = 20
net.netfilter.nf_conntrack_tcp_timeout_time_wait = 10
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.ip_no_pmtu_disc = 1
net.ipv4.route.flush = 1
net.ipv4.route.max_size = 8048576
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.tcp_congestion_control = htcp
net.ipv4.tcp_mem = 65536 131072 262144
net.ipv4.udp_mem = 65536 131072 262144
net.ipv4.tcp_rmem = 4096 87380 33554432
net.ipv4.udp_rmem_min = 16384
net.ipv4.tcp_wmem = 4096 87380 33554432
net.ipv4.udp_wmem_min = 16384
net.ipv4.tcp_max_tw_buckets = 1440000
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_max_orphans = 400000
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rfc1337 = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_sack = 1
net.ipv4.tcp_fack = 1
net.ipv4.tcp_ecn = 2
net.ipv4.tcp_fin_timeout = 10
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_intvl = 60
net.ipv4.tcp_keepalive_probes = 10
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.ip_forward = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.all.rp_filter = 1
net.ipv4.ip_nonlocal_bind = 1' >> /etc/sysctl.conf

touch /etc/security/limits.d/nofile.conf
echo '*    soft    nofile 65535'> /etc/security/limits.d/nofile.conf
echo '*    hard    nofile 65535' >> /etc/security/limits.d/nofile.conf

sysctl -p



fi


if [ "$change_port_yn" = "y" ]; then
cp /usr/local/vesta/nginx/conf/nginx.conf /usr/local/vesta/nginx/conf/nginx.conf.bak.$random
cp /usr/local/vesta/data/firewall/rules.conf /usr/local/vesta/data/firewall/rules.conf.bak.$random
sed -i '/8083;/a listen 2083;' /usr/local/vesta/nginx/conf/nginx.conf
service vesta restart
sed -i "s#8083#8083,2083#g" /usr/local/vesta/data/firewall/rules.conf

/usr/local/vesta/bin/v-update-firewall


#if [ "$vDDoS_yn" = "y" ]; then
#/usr/local/vesta/bin/v-delete-firewall-rule 2
#/usr/local/vesta/bin/v-update-firewall
#fi

fi

if [ "$auto_config_PHP_yn" = "y" ]; then
cp /etc/php.ini /etc/php.ini.bak.$random
sed -i "/^short_open_tag/c short_open_tag = On" /etc/php.ini
sed -i '/^;default_charset/c default_charset = "UTF-8"' /etc/php.ini
sed -i "/^post_max_size/c post_max_size = 500M" /etc/php.ini
sed -i "/^upload_max_filesize/c upload_max_filesize = 500M" /etc/php.ini
sed -i "/^memory_limit/c memory_limit = 500M" /etc/php.ini
sed -i "/^max_execution_time/c max_execution_time = 5000" /etc/php.ini
fi








if [ "$vDDoS_yn" = "y" ]; then
s='80' ; r='8080'
sed -i "s#$s#$r#g" /usr/local/vesta/conf/vesta.conf
s='443' ; r='8443'
sed -i "s#$s#$r#g" /usr/local/vesta/conf/vesta.conf

s=':8081' ; r=':8888'
sed -i "s#$s#$r#g" /etc/httpd/conf.d/*.conf >/dev/null 2>&1
s=':80' ; r=':8080'
sed -i "s#$s#$r#g" /etc/httpd/conf.d/*.conf >/dev/null 2>&1
s=':443' ; r=':8443'
sed -i "s#$s#$r#g" /etc/httpd/conf.d/*.conf >/dev/null 2>&1
s=':8888' ; r=':8081'
sed -i "s#$s#$r#g" /etc/httpd/conf.d/*.conf >/dev/null 2>&1

s=':8084' ; r=':8888'
sed -i "s#$s#$r#g" /etc/nginx/conf.d/*.conf >/dev/null 2>&1
s=':80' ; r=':8080'
sed -i "s#$s#$r#g" /etc/nginx/conf.d/*.conf >/dev/null 2>&1
s=':443' ; r=':8443'
sed -i "s#$s#$r#g" /etc/nginx/conf.d/*.conf >/dev/null 2>&1
s=':8888' ; r=':8084'
sed -i "s#$s#$r#g" /etc/nginx/conf.d/*.conf >/dev/null 2>&1

service vesta restart

VESTA='/usr/local/vesta/'
source /etc/profile.d/vesta.sh >/dev/null 2>&1
source /root/.bash_profile >/dev/null 2>&1
source /etc/sysconfig/clock >/dev/null 2>&1
source /usr/local/vesta/func/main.sh >/dev/null 2>&1
source /usr/local/vesta/conf/vesta.conf >/dev/null 2>&1
/usr/local/vesta/bin/v-rebuild-web-domains admin
fi

if [ "$File_Manager_yn" = "y" ]; then
curl -L https://raw.githubusercontent.com/duy13/VDVESTA/master/File-Manager -o File-Manager
goc=`curl -L https://raw.githubusercontent.com/duy13/VDVESTA/master/md5sum.txt --silent | grep "File-Manager" |awk 'NR==1 {print $1}'`
tai=`md5sum File-Manager | awk 'NR==1 {print $1}'`
if [ "$goc" != "$tai" ]; then
curl -L http://files.voduy.com/VDVESTA/File-Manager -o File-Manager
fi
chmod 700 File-Manager
./File-Manager
rm -f File-Manager
cp /usr/local/vesta/web/css/styles.min.css /usr/local/vesta/web/css/styles.min.css.bak.$random
s='background-position: -117px -7px;'
r='background-position: -117px -55px;'
sed -i "s#$s#$r#g"  /usr/local/vesta/web/css/styles.min.css
s='5d5d5d;'
r='DF0022;'
num=$(( $RANDOM % 9 + 1))
if [ $num = '1' ]; then r="DF0022;"; fi
if [ $num = '2' ]; then r="9cdf00;"; fi
if [ $num = '3' ]; then r="00df4a;"; fi
if [ $num = '4' ]; then r="00dfbd;"; fi
if [ $num = '5' ]; then r="6400df;"; fi
if [ $num = '6' ]; then r="0068df;"; fi
if [ $num = '7' ]; then r="34df00;"; fi
if [ $num = '8' ]; then r="00df8d;"; fi
if [ $num = '9' ]; then r="000000;"; fi
sed -i "s#$s#$r#g" /usr/local/vesta/web/css/styles.min.css

VESTA='/usr/local/vesta/'
source /etc/profile.d/vesta.sh >/dev/null 2>&1
source /root/.bash_profile >/dev/null 2>&1
source /etc/sysconfig/clock >/dev/null 2>&1
source /usr/local/vesta/func/main.sh >/dev/null 2>&1
source /usr/local/vesta/conf/vesta.conf >/dev/null 2>&1

#/usr/local/vesta/bin/v-delete-cron-job admin 8 >/dev/null 2>&1

/usr/local/vesta/bin/v-delete-user-package gainsboro >/dev/null 2>&1
/usr/local/vesta/bin/v-delete-user-package palegreen >/dev/null 2>&1
/usr/local/vesta/bin/v-delete-user-package slategrey >/dev/null 2>&1

echo "WEB_TEMPLATE='default'
BACKEND_TEMPLATE='default'
PROXY_TEMPLATE='default'
DNS_TEMPLATE='default'
WEB_DOMAINS='unlimited'
WEB_ALIASES='unlimited'
DNS_DOMAINS='unlimited'
DNS_RECORDS='unlimited'
MAIL_DOMAINS='unlimited'
MAIL_ACCOUNTS='unlimited'
DATABASES='unlimited'
CRON_JOBS='unlimited'
DISK_QUOTA='1000'
BANDWIDTH='unlimited'
NS='ns1.localhost.ltd,ns2.localhost.ltd'
SHELL='nologin'
BACKUPS='1'
TIME='11:46:50'
DATE='2015-06-05'" > 1GB.pkg
echo "WEB_TEMPLATE='default'
BACKEND_TEMPLATE='default'
PROXY_TEMPLATE='default'
DNS_TEMPLATE='default'
WEB_DOMAINS='unlimited'
WEB_ALIASES='unlimited'
DNS_DOMAINS='unlimited'
DNS_RECORDS='unlimited'
MAIL_DOMAINS='unlimited'
MAIL_ACCOUNTS='unlimited'
DATABASES='unlimited'
CRON_JOBS='unlimited'
DISK_QUOTA='2000'
BANDWIDTH='unlimited'
NS='ns1.localhost.ltd,ns2.localhost.ltd'
SHELL='nologin'
BACKUPS='1'
TIME='11:46:50'
DATE='2015-06-05'" > 2GB.pkg
echo "WEB_TEMPLATE='default'
BACKEND_TEMPLATE='default'
PROXY_TEMPLATE='default'
DNS_TEMPLATE='default'
WEB_DOMAINS='unlimited'
WEB_ALIASES='unlimited'
DNS_DOMAINS='unlimited'
DNS_RECORDS='unlimited'
MAIL_DOMAINS='unlimited'
MAIL_ACCOUNTS='unlimited'
DATABASES='unlimited'
CRON_JOBS='unlimited'
DISK_QUOTA='3000'
BANDWIDTH='unlimited'
NS='ns1.localhost.ltd,ns2.localhost.ltd'
SHELL='nologin'
BACKUPS='1'
TIME='11:46:50'
DATE='2015-06-05'" > 3GB.pkg
echo "WEB_TEMPLATE='default'
BACKEND_TEMPLATE='default'
PROXY_TEMPLATE='default'
DNS_TEMPLATE='default'
WEB_DOMAINS='unlimited'
WEB_ALIASES='unlimited'
DNS_DOMAINS='unlimited'
DNS_RECORDS='unlimited'
MAIL_DOMAINS='unlimited'
MAIL_ACCOUNTS='unlimited'
DATABASES='unlimited'
CRON_JOBS='unlimited'
DISK_QUOTA='5000'
BANDWIDTH='unlimited'
NS='ns1.localhost.ltd,ns2.localhost.ltd'
SHELL='nologin'
BACKUPS='1'
TIME='11:46:50'
DATE='2015-06-05'" > 5GB.pkg
echo "WEB_TEMPLATE='default'
BACKEND_TEMPLATE='default'
PROXY_TEMPLATE='default'
DNS_TEMPLATE='default'
WEB_DOMAINS='unlimited'
WEB_ALIASES='unlimited'
DNS_DOMAINS='unlimited'
DNS_RECORDS='unlimited'
MAIL_DOMAINS='unlimited'
MAIL_ACCOUNTS='unlimited'
DATABASES='unlimited'
CRON_JOBS='unlimited'
DISK_QUOTA='10000'
BANDWIDTH='unlimited'
NS='ns1.localhost.ltd,ns2.localhost.ltd'
SHELL='nologin'
BACKUPS='1'
TIME='11:46:50'
DATE='2015-06-05'" > 10GB.pkg
echo "WEB_TEMPLATE='default'
BACKEND_TEMPLATE='default'
PROXY_TEMPLATE='default'
DNS_TEMPLATE='default'
WEB_DOMAINS='unlimited'
WEB_ALIASES='unlimited'
DNS_DOMAINS='unlimited'
DNS_RECORDS='unlimited'
MAIL_DOMAINS='unlimited'
MAIL_ACCOUNTS='unlimited'
DATABASES='unlimited'
CRON_JOBS='unlimited'
DISK_QUOTA='50000'
BANDWIDTH='unlimited'
NS='ns1.localhost.ltd,ns2.localhost.ltd'
SHELL='nologin'
BACKUPS='1'
TIME='11:46:50'
DATE='2015-06-05'" > 50GB.pkg





/usr/local/vesta/bin/v-add-user-package `pwd` 1GB >/dev/null 2>&1
/usr/local/vesta/bin/v-add-user-package `pwd` 2GB >/dev/null 2>&1
/usr/local/vesta/bin/v-add-user-package `pwd` 3GB >/dev/null 2>&1
/usr/local/vesta/bin/v-add-user-package `pwd` 5GB >/dev/null 2>&1
/usr/local/vesta/bin/v-add-user-package `pwd` 10GB >/dev/null 2>&1
/usr/local/vesta/bin/v-add-user-package `pwd` 50GB >/dev/null 2>&1
rm -rf *.pkg

fi

if [ ! -f /etc/rc.d/init.d/vesta ]; then
	echo 'Install VESTACP Fail!';
	exit 0
fi

cp /usr/local/vesta/data/templates/web/httpd/default.tpl /usr/local/vesta/data/templates/web/httpd/nobasedir.tpl
cp /usr/local/vesta/data/templates/web/httpd/default.stpl /usr/local/vesta/data/templates/web/httpd/nobasedir.stpl
basedir='php_admin_value open_basedir'
sed -i "/.*$basedir.*/d" /usr/local/vesta/data/templates/web/httpd/nobasedir.tpl
sed -i "/.*$basedir.*/d" /usr/local/vesta/data/templates/web/httpd/nobasedir.stpl

if [ "$PHP_Selector_yn" = "y" ]; then
cp -r /etc/httpd /etc/httpd-bak-$random
curl -L https://raw.githubusercontent.com/duy13/VDVESTA/master/PHP-Selector -o PHP-Selector
goc=`curl -L https://raw.githubusercontent.com/duy13/VDVESTA/master/md5sum.txt --silent | grep "PHP-Selector" |awk 'NR==1 {print $1}'`
tai=`md5sum PHP-Selector | awk 'NR==1 {print $1}'`
if [ "$goc" != "$tai" ]; then
curl -L http://1.voduy.com/VDVESTA/PHP-Selector -o PHP-Selector
fi
chmod 700 PHP-Selector
./PHP-Selector
rm -f PHP-Selector
rm -rf /etc/httpd
mv /etc/httpd-bak-$random /etc/httpd

if [ "$auto_config_PHP_yn" = "y" ]; then
cp /opt/remi/php54/root/etc/php.ini /opt/remi/php54/root/etc/php.ini.bak.$random
sed -i "/^short_open_tag/c short_open_tag = On" /opt/remi/php54/root/etc/php.ini
sed -i '/^;default_charset/c default_charset = "UTF-8"' /opt/remi/php54/root/etc/php.ini
sed -i "/^post_max_size/c post_max_size = 500M" /opt/remi/php54/root/etc/php.ini
sed -i "/^upload_max_filesize/c upload_max_filesize = 500M" /opt/remi/php54/root/etc/php.ini
sed -i "/^memory_limit/c memory_limit = 500M" /opt/remi/php54/root/etc/php.ini
sed -i "/^max_execution_time/c max_execution_time = 5000" /opt/remi/php54/root/etc/php.ini

cp /opt/remi/php55/root/etc/php.ini /opt/remi/php55/root/etc/php.ini.bak.$random
sed -i "/^short_open_tag/c short_open_tag = On" /opt/remi/php55/root/etc/php.ini
sed -i '/^;default_charset/c default_charset = "UTF-8"' /opt/remi/php55/root/etc/php.ini
sed -i "/^post_max_size/c post_max_size = 500M" /opt/remi/php55/root/etc/php.ini
sed -i "/^upload_max_filesize/c upload_max_filesize = 500M" /opt/remi/php55/root/etc/php.ini
sed -i "/^memory_limit/c memory_limit = 500M" /opt/remi/php55/root/etc/php.ini
sed -i "/^max_execution_time/c max_execution_time = 5000" /opt/remi/php55/root/etc/php.ini

cp /opt/remi/php56/root/etc/php.ini /opt/remi/php56/root/etc/php.ini.bak.$random
sed -i "/^short_open_tag/c short_open_tag = On" /opt/remi/php56/root/etc/php.ini
sed -i '/^;default_charset/c default_charset = "UTF-8"' /opt/remi/php56/root/etc/php.ini
sed -i "/^post_max_size/c post_max_size = 500M" /opt/remi/php56/root/etc/php.ini
sed -i "/^upload_max_filesize/c upload_max_filesize = 500M" /opt/remi/php56/root/etc/php.ini
sed -i "/^memory_limit/c memory_limit = 500M" /opt/remi/php56/root/etc/php.ini
sed -i "/^max_execution_time/c max_execution_time = 5000" /opt/remi/php56/root/etc/php.ini

cp /etc/opt/remi/php70/php.ini /etc/opt/remi/php70/php.ini.bak.$random
sed -i "/^short_open_tag/c short_open_tag = On" /etc/opt/remi/php70/php.ini
sed -i '/^;default_charset/c default_charset = "UTF-8"' /etc/opt/remi/php70/php.ini
sed -i "/^post_max_size/c post_max_size = 500M" /etc/opt/remi/php70/php.ini
sed -i "/^upload_max_filesize/c upload_max_filesize = 500M" /etc/opt/remi/php70/php.ini
sed -i "/^memory_limit/c memory_limit = 500M" /etc/opt/remi/php70/php.ini
sed -i "/^max_execution_time/c max_execution_time = 5000" /etc/opt/remi/php70/php.ini

cp /etc/opt/remi/php71/php.ini /etc/opt/remi/php71/php.ini.bak.$random
sed -i "/^short_open_tag/c short_open_tag = On" /etc/opt/remi/php71/php.ini
sed -i '/^;default_charset/c default_charset = "UTF-8"' /etc/opt/remi/php71/php.ini
sed -i "/^post_max_size/c post_max_size = 500M" /etc/opt/remi/php71/php.ini
sed -i "/^upload_max_filesize/c upload_max_filesize = 500M" /etc/opt/remi/php71/php.ini
sed -i "/^memory_limit/c memory_limit = 500M" /etc/opt/remi/php71/php.ini
sed -i "/^max_execution_time/c max_execution_time = 5000" /etc/opt/remi/php71/php.ini

cp /etc/opt/remi/php72/php.ini /etc/opt/remi/php72/php.ini.bak.$random
sed -i "/^short_open_tag/c short_open_tag = On" /etc/opt/remi/php72/php.ini
sed -i '/^;default_charset/c default_charset = "UTF-8"' /etc/opt/remi/php72/php.ini
sed -i "/^post_max_size/c post_max_size = 500M" /etc/opt/remi/php72/php.ini
sed -i "/^upload_max_filesize/c upload_max_filesize = 500M" /etc/opt/remi/php72/php.ini
sed -i "/^memory_limit/c memory_limit = 500M" /etc/opt/remi/php72/php.ini
sed -i "/^max_execution_time/c max_execution_time = 5000" /etc/opt/remi/php72/php.ini

echo '<IfModule mod_fcgid.c>
  AddHandler    fcgid-script .fcgi
  FcgidConnectTimeout 20
  FcgidMinProcessesPerClass 0
  FcgidMaxProcessesPerClass 10
  FcgidMaxProcesses 50
  FcgidIdleTimeout 20
  FcgidProcessLifeTime 120
  FcgidIdleScanInterval 30


  # Change the rate at which new FastCGI processes are spawned under load. Higher=faster
  FcgidSpawnScoreUpLimit 10

  # Higher number = spawning more FastCGI processes decreases the spawn rate (controls runaway
  FcgidSpawnScore 2

  # Higher number = terminating FastCGI processes decreases the spawn rate (controls runaway)
  FcgidTerminationScore 2

  # Increase the FastCGI max request length for large file uploads (needed for some sites)
  FcgidMaxRequestLen 10000000

  FcgidMaxRequestsPerProcess 100000
  FcgidIOTimeout 1800
</IfModule>
' >> /etc/httpd/conf.d/fcgid.conf
fi

service httpd restart >/dev/null 2>&1

fi


if [ "$vDDoS_yn" = "y" ]; then
# Install vDDoS Proxy Protection:

latest_version=`/usr/bin/curl -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/CHANGELOG.txt|grep '*vDDoS-' |awk 'NR==1' |tr -d '*vDDoS-'|tr -d ':'`
/usr/bin/curl -L https://github.com/duy13/vDDoS-Protection/raw/master/vddos-$latest_version.tar.gz -o vddos-$latest_version.tar.gz

originhash=`curl -L https://raw.githubusercontent.com/duy13/vDDoS-Protection/master/md5sum.txt --silent | grep "vddos-$latest_version.tar.gz" |awk 'NR=1 {print $1}'`
downloadhash=`md5sum vddos-$latest_version.tar.gz | awk 'NR=1 {print $1}'`
if [ "$originhash" != "$downloadhash" ]; then
	echo 'Download vddos-'$latest_version'.tar.gz from Github.com failed! Try Downloading from SourceForge.net...'
	rm -rf vddos-$latest_version.tar.gz
	curl -L https://sourceforge.net/projects/vddos-protection/files/vddos-$latest_version.tar.gz -o vddos-$latest_version.tar.gz

	originhash=`curl -L https://sourceforge.net/projects/vddos-protection/files/md5sum.txt --silent | grep "vddos-$latest_version.tar.gz" |awk 'NR=1 {print $1}'`
	downloadhash=`md5sum vddos-$latest_version.tar.gz | awk 'NR=1 {print $1}'`
	if [ "$originhash" != "$downloadhash" ]; then
		echo 'Download vddos-'$latest_version'.tar.gz from SourceForge.net failed! Try Downloading from Files.voduy.com...'
		rm -rf vddos-$latest_version.tar.gz
		curl -L https://files.voduy.com/vDDoS-Proxy-Protection/vddos-$latest_version.tar.gz -o vddos-$latest_version.tar.gz
	fi

fi

tar -xvf vddos-$latest_version.tar.gz >/dev/null 2>&1
cd vddos-$latest_version
chmod 755 -R *.sh  >/dev/null 2>&1
chmod 755 -R */*.sh  >/dev/null 2>&1
./install.sh master

if [ -f /vddos/vddos ]; then

	curl -L https://github.com/duy13/vDDoS-Layer4-Mapping/raw/master/vddos-layer4-mapping -o /usr/bin/vddos-layer4
	chmod 700 /usr/bin/vddos-layer4

	echo 'Install vDDoS Proxy Protection Done!'

	/root/.acme.sh/acme.sh --set-default-ca  --server  letsencrypt >/dev/null 2>&1
	
else
	echo 'Install vDDoS Proxy Protection Failed!'
	exit 1
fi



if [ "$Web_Server_version" = "--nginx no --apache yes --phpfpm no" ]; then
service httpd restart >/dev/null 2>&1
fi
if [ "$Web_Server_version" = "--nginx yes --apache no --phpfpm yes" ]; then
service nginx restart >/dev/null 2>&1
fi
IPWEB=`netstat -lntup|grep 8080| awk {'print $4'}| awk 'NR==1'| tr : " "| awk {'print $1'}`

echo '
default http://0.0.0.0:80    http://'$IPWEB':8080    no    no    no           no
default https://0.0.0.0:443  https://'$IPWEB':8443  no    no    /vddos/ssl/your-domain.com.pri /vddos/ssl/your-domain.com.crt
' >> /vddos/conf.d/website.conf


echo '# Default Setting for vddos-add command:

SSL				auto
DNS_sleep 		66
DNS_alias_mode	no
Cache			no
Security		no
HTTP_Listen		http://0.0.0.0:80
HTTPS_Listen	https://0.0.0.0:443
HTTP_Backend	http://'$IPWEB':8080
HTTPS_Backend	https://'$IPWEB':8443
' > /vddos/auto-add/setting.conf

echo 'Install vDDoS Auto Add Done!'




if [ "$Varnish_yn" = "y" ]; then
curl -L https://github.com/duy13/VDVARNISH/raw/master/vdvarnish.sh -o vdvarnish.sh
goc=`curl -L https://raw.githubusercontent.com/duy13/vdvarnish/master/md5sum.txt --silent | grep "vdvarnish.sh" |awk 'NR==1 {print $1}'`
tai=`md5sum vdvarnish.sh | awk 'NR==1 {print $1}'`
if [ "$goc" != "$tai" ]; then
	rm -rf vdvarnish.sh
	curl -L https://3.voduy.com/VDVARNISH/vdvarnish.sh -o vdvarnish.sh
fi
bash vdvarnish.sh noask

Varnish_Server_sizecache=$((`cat /proc/meminfo|grep MemTotal|awk {'print $2'}`/1024/3))
Varnish_Server_port=82
Varnish_Backend_ip=$IPWEB
Varnish_Backend_port=8080

sed -i "s#82#$Varnish_Server_port#g" /etc/varnish/varnish.params
sed -i "s#512#$Varnish_Server_sizecache#g" /etc/varnish/varnish.params
sed -i "s#127.0.0.1#$Varnish_Backend_ip#g" /etc/varnish/default.vcl
sed -i "s#8080#$Varnish_Backend_port#g" /etc/varnish/default.vcl

echo 'Install Varnish Cache Done!'
fi



fi


/usr/bin/vddos restart >/dev/null 2>&1
service mariadb restart >/dev/null 2>&1
service memcached restart >/dev/null 2>&1


if [ "$Web_Server_version" = "--nginx yes --apache no --phpfpm yes" ]; then
echo '[%backend%]
listen = /var/run/php5-%backend%.sock
listen.allowed_clients = 127.0.0.1
user = %user%
group = %user%
listen.owner = %user%
listen.group = nginx
pm = ondemand
pm.max_children = 50
pm.start_servers = 3
pm.min_spare_servers = 2
pm.max_spare_servers = 10
pm.process_idle_timeout = 10s
pm.max_requests = 500
env[HOSTNAME] = $HOSTNAME
env[PATH] = /usr/local/bin:/usr/bin:/bin
env[TMP] = /tmp
env[TMPDIR] = /tmp
env[TEMP] = /tmp' > /usr/local/vesta/data/templates/web/php-fpm/VDVESTA-Socket.tpl
chkconfig httpd off >/dev/null 2>&1
service nginx restart >/dev/null 2>&1
fi

if [ "$Web_Server_version" = "--nginx no --apache yes --phpfpm no" ]; then
chkconfig nginx off >/dev/null 2>&1
service httpd restart >/dev/null 2>&1
fi
if [ "$vDDoS_yn" = "y" ]; then
if [ ! -f /root/.acme.sh/$hostname_i/fullchain.cer ]; then
yum -y install socat
wget -O -  https://get.acme.sh | sh
/root/.acme.sh/acme.sh --set-default-ca  --server  letsencrypt >/dev/null 2>&1
echo '@monthly root sleep 10 && service vesta restart' | sudo tee --append /etc/crontab  >/dev/null 2>&1
service httpd restart >/dev/null 2>&1
service nginx restart >/dev/null 2>&1
/root/.acme.sh/acme.sh --issue -d $hostname_i -w /vddos/letsencrypt
	if [ -f /root/.acme.sh/$hostname_i/fullchain.cer ]; then
echo '
'$hostname_i' https://0.0.0.0:443  https://127.0.0.1:8083  no    no    /root/.acme.sh/'$hostname_i'/'$hostname_i'.key /root/.acme.sh/'$hostname_i'/fullchain.cer
' >> /vddos/conf.d/website.conf
/usr/bin/vddos restart >/dev/null 2>&1
echo "404" > /home/admin/web/$hostname_i/public_html/index.html
	fi
fi
fi

if [ "$vDDoS_yn" = "y" ] && [ "$Web_Server_version" = "--nginx no --apache yes --phpfpm no" ]; then
	echo '*/21  *  *  *  * root /usr/bin/vddos-autoadd panel vestacp apache' >> /etc/crontab
	echo '2 2 * * * root acme.sh --upgrade ; vddos-autoadd ssl-again' >> /etc/crontab
fi
if [ "$vDDoS_yn" = "y" ] && [ "$Web_Server_version" = "--nginx yes --apache no --phpfpm yes" ]; then
	echo '*/21  *  *  *  * root /usr/bin/vddos-autoadd panel vestacp nginx' >> /etc/crontab
	echo '2 2 * * * root acme.sh --upgrade ; vddos-autoadd ssl-again' >> /etc/crontab
fi

/usr/local/vesta/bin/v-delete-cron-vesta-autoupdate >/dev/null 2>&1
service vesta restart >/dev/null 2>&1
/usr/bin/curl --silent --header "X-Install: vDVESTA" https://files.voduy.com/iplog.php

if [ "$PHP_Selector_yn" = "y" ]; then
curl -L https://github.com/duy13/VDVESTA/raw/master/freeram.sh -o /root/freeram.sh
echo '* * * * * root bash /root/freeram.sh' >> /etc/crontab
fi

curl -L https://github.com/duy13/VDVESTA/raw/master/autosuspend.sh -o /root/autosuspend.sh
echo '3 */5 * * * root bash /root/autosuspend.sh' >> /etc/crontab


s='force_local_logins_ssl=YES' ; r='force_local_logins_ssl=NO'
sed -i "s#$s#$r#g" /etc/vsftpd/vsftpd.conf
s='force_local_data_ssl=YES' ; r='force_local_data_ssl=NO'
sed -i "s#$s#$r#g" /etc/vsftpd/vsftpd.conf
service vsftpd restart

clear
if [ "$Web_Server_version" = "--nginx no --apache yes --phpfpm no" ]; then
httpd -v
fi

if [ "$Web_Server_version" = "--nginx yes --apache no --phpfpm yes" ]; then
nginx -v
fi
if [ "$Varnish_yn" = "y" ]; then
varnishd -V
fi
mysql -V
php -v
if [ "$vDDoS_yn" != "y" ]; then
echo '
=====> Install and Config VDVESTA Done! <=====
VestaCP: https://'$hostname_i':2083 or https://'$IP':8083
	username: admin
	password: '$password'

 Please reboot!
'
fi
if [ "$vDDoS_yn" = "y" ]; then
echo '
=====> Install and Config VDVESTA Done! <=====
VestaCP: https://'$hostname_i'
	username: admin
	password: '$password'

 Please reboot!
'
fi
