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

Would you like +install vDDoS Proxy Protection [Y|n]:
vDDoS Proxy Protection install => y
Which Web Server version you want to install [apache|nginx]:
Web Server version => apache
Which PHP Server version you want to install [all|5.4|5.5|5.6|7.0|7.1]:
PHP Server version => 7.1
Would you like auto config PHP [Y|n]:
Auto config PHP => y
Which MariaDB Server version you want to install [5.5|10.0|10.1]:
MariaDB Server version => 10.1
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
mysql  Ver 15.1 Distrib 10.1.28-MariaDB, for Linux (x86_64) using readline 5.1
PHP 7.1.10 (cli) (built: Sep 27 2017 08:27:18) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.1.10, Copyright (c) 1999-2017, by Zend Technologies

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
Document: http://vdvesta.voduy.com
```
Still in beta, use at your own risk! It is provided without any warranty!
```
