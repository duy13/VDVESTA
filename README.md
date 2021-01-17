VDVESTA
===================

VDVESTA is a small shell script auto Custom & Install VESTACP for your CentOS Server Release 7 x86_64.

VESTACP from: https://vestacp.com/install
(Please buy Commercial Vesta's plugins if you can!)

----------

1/ VDVESTA System Requirements:
-------------
Install CentOS Server 7 x86_64: http://centos.org/

----------


2/ VDVESTA Install:
-------------
```
yum -y update
curl -L https://github.com/duy13/VDVESTA/raw/master/vdvesta.sh -o vdvesta.sh
bash vdvesta.sh
 
```

vdvesta script interface:
-------------
```
        Welcome to VDVESTA:
A shell script auto Custom & Install VESTACP for your CentOS Server Release 7 x86_64.
                                                                Thanks you for using!

        Welcome to VDVESTA:
A shell script auto Custom & Install VESTACP for your CentOS Server Release 7 x86_64.
                                                                Thanks you for using!


 LAMP5: Apache + PHP 5.4 + MariaDB 5.5
 LAMP7: Apache + PHP 7.4 + MariaDB 10.5
 LAMP8: Apache + PHP 8.0 + MariaDB 10.5

 LEMP7: Nginx + PHP 7.4 + MariaDB 10.5
 LEMP8: Nginx + PHP 8.0 + MariaDB 10.5

Which Web Server version you want to install [lamp5|lamp7|lemp7|lamp8|lemp8]:
Web Server version install => lamp7
Would you like +install vDDoS Proxy Protection [Y|n]:
vDDoS Proxy Protection install => y
Would you like +install Varnish Cache [Y|n]:
Varnish Proxy Server install => y
Would you like auto config PHP [Y|n]:
Auto config PHP => y
Would you like +install File Manager [Y|n]:
File Manager install => y
Would you like +install Zend optimize plus opcode cache [Y|n]:
Zend Opcode Cache install => y
Would you like +install Memcached [Y|n]:
Memcached install => y
Would you like +install Limit Hosting (limit CPU, RAM, IO your hosting account) [Y|n]:
Limit Hosting install => y
Would you like Configure Kernel limit DDOS [Y|n]:
Kernel limit DDOS => y
Would you like change port VestaCP 8083 to 2083 [Y|n]:
Change port VestaCP 8083 to 2083 => y
Would you like +install Spamassassin & Clamav [y|N]:
Install Spamassassin & Clamav => n
Would you like +install Fail2ban [y|N]:
Install Fail2ban => n
Enter your hostname [v1.your-domain.com]:
Hostname => v1.your-domain.com
Enter your Email [admin@v1.your-domain.com]:
Email => admin@v1.your-domain.com


 _|      _|  _|_|_|_|    _|_|_|  _|_|_|_|_|    _|_|
 _|      _|  _|        _|            _|      _|    _|
 _|      _|  _|_|_|      _|_|        _|      _|_|_|_|
   _|  _|    _|              _|      _|      _|    _|
     _|      _|_|_|_|  _|_|_|        _|      _|    _|

                                  Vesta Control Panel



Following software will be installed on your system:
   - Apache Web Server
   - Bind DNS Server
   - Exim mail server
   - Dovecot POP3/IMAP Server
   - MariaDB Database Server
   - Vsftpd FTP Server
   - Iptables Firewall


Would you like to continue [y/n]: y

......................................
......................................
......................................
......................................

......................................
......................................
......................................
......................................

Server version: Apache/2.4.16 (Unix)
varnishd (varnish-4.1.11 revision 61367ed17d08a9ef80a2d42dc84caef79cdeee7a)
Copyright (c) 2006 Verdens Gang AS
Copyright (c) 2006-2019 Varnish Software AS
mysql Ver 15.1 Distrib 10.5.8-MariaDB, for Linux (x86_64) using readline 5.1
PHP 7.4.11 (cli) (built: Jan 5 2021 13:54:54) ( NTS gcc x86_64 )
Copyright (c) The PHP Group
Zend Engine v4.0.1, Copyright (c) Zend Technologies
with Zend OPcache v8.0.1, Copyright (c), by Zend Technologies

=====> Install and Config VDVESTA Done! <=====
 Link VestaCP: https://v1.your-domain.com:2083 or https://13.9.19.90:8083
        username: admin
        password: A7#nC

 Please reboot!

```

VDVESTA screenshot:
-------------
![VDVESTA Screenshot](https://lh4.googleusercontent.com/-nS-2ZADtcpM/WK0GalcZfiI/AAAAAAAABI0/NELyFr6k-iMQkVEOGKylP55ibSDliu2gQCLcB/s1600/VDVESTA.png "vdvesta screenshot 1")

PHP Selector:
-------------
![VDVESTA PHP Selector 5.4 5.5 5.6 7.0 7.1 7.2](https://lh4.googleusercontent.com/-YFjtfRtpJHY/Wcx4S2QDgYI/AAAAAAAABpE/8LjWA9JylbQMVZX46bnn4i23Qt8GIcF0ACLcBGAs/s1600/VDVESTA-PHP-Selector.png.png "vdvesta php selector screenshot 2")

Limit Hosting:
-------------
![VDVESTA Limit Hosting CPU-RAM-IO](https://lh4.googleusercontent.com/-Oi4bsdKcKfI/WYs502wI7TI/AAAAAAAABms/9At8G3STbmc3MNEuXe8kInlzFNb53vcWgCLcBGAs/s1600/VDVESTA-Limit-Hosting.png "vdvesta limit hosting screenshot 3")

3/ More Config:
---------------
HomePage: http://vdvesta.voduy.com

Forum Support: https://link.voduy.com/forum-vdvesta
```
Still in beta, use at your own risk! It is provided without any warranty!
```
