#-------------------------------------------------------------------
# src/etc/php.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         php.sh
# Author:       Ragdata
# Date:         24/02/2021 1600
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing PHP7.4 + Extensions"
echoLog "spacer"

apt_install php7.4
echoLog "PHP7.4 Extensions: " -n
if apt install -y php7.4-{amqp,apcu,bcmath,bz2,cgi,cli,common,curl,ds,fpm,gd,geoip,gmp,gnupg,http,imagick,imap,intl,json,ldap,lua,mbstring,mysql,mailparse,oauth,odbc,opcache,pcov,pdo,pgsql,pspell,propro,psr,raphf,readline,redis,sass,ssh2,smbclient,sqlite3,stomp,tideways,tidy,uploadprogress,uuid,xhprof,xml,xmlrpc,yaml,zip,zmq}; then echoLog "y" -c; else echoLog "n" -c; fi

echoLog "spacer"
echoLog "${BR3}PHP7.4${_A} Successfully Installed!"

echoLog "spacer"
echoLog "Configure PHP7.4"
echoLog "spacer"

TIME_ZONE=$(cat /etc/timezone)

sed -i 's/short_open_tag=Off/short_open_tag=On/' /etc/php/7.4/fpm/php.ini
sed -i 's/;highlight./highlight/' /etc/php/7.4/fpm/php.ini
sed -i '/error_reporting.*/c\error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE' /etc/php/7.4/fpm/php.ini
sed -i 's/enable_dl = Off/enable_dl = On/' /etc/php/7.4/fpm/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/7.4/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 25M/' /etc/php/7.4/fpm/php.ini
sed -i "s/;date.timezone =/date.timezone=\"${TIME_ZONE//\//\\/}\"/" /etc/php/7.4/fpm/php.ini
sed -i "/^memory_limit./c\memory_limit = 512M" /etc/php/7.4/fpm/php.ini

cp /etc/php/7.4/fpm/php.ini /etc/php/7.4/cli/.

sed -i 's/;clear_env/clear_env/g' /etc/php/7.4/fpm/pool.d/www.conf

echoLog "Restarting PHP7.4-FPM: " -n
if service php7.4-fpm restart; then echoLog "SUCCESS" -c; else echoLog "FAILURE!" -c; fi

echoLog "spacer"
echoLog "${BR3}PHP7.4${_A} Configured!"
