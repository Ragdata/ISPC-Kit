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
echo "Installing PHP8.0 + Extensions ..."
log "spacer"
log "PHP8.0 + Extensions"
log "line"
echo

apt_install php8.0
log "PHP8.0 Extensions: " -n
if apt install -y php8.0-{amqp,apcu,bcmath,bz2,cgi,cli,common,curl,ds,fpm,gd,gmp,gnupg,http,imagick,imap,intl,ldap,mailparse,mbstring,mysql,oauth,odbc,opcache,pdo,pgsql,propro,pspell,psr,raphf,readline,redis,smbclient,sqlite3,tidy,uuid,xhprof,xml,xmlrpc,yaml,zip,zmq}; then log "y" -c; else log "n" -c; fi

echo
echo -e "${yellow}PHP8.0${NC} Successfully Installed!"
echo

echo "Configure PHP8.0 ..."
log "spacer"
log "Configuring PHP8.0 ..."

TIME_ZONE=$(cat /etc/timezone)

sed -i 's/short_open_tag=Off/short_open_tag=On/' /etc/php/8.0/fpm/php.ini
sed -i 's/;highlight./highlight/' /etc/php/8.0/fpm/php.ini
sed -i '/^error_reporting.*/c\error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE' /etc/php/8.0/fpm/php.ini
sed -i 's/enable_dl = Off/enable_dl = On/' /etc/php/8.0/fpm/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.0/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 25M/' /etc/php/8.0/fpm/php.ini
sed -i "s/;date.timezone =/date.timezone=\"${TIME_ZONE//\//\\/}\"/" /etc/php/8.0/fpm/php.ini
sed -i "/^memory_limit./c\memory_limit = 512M" /etc/php/8.0/fpm/php.ini

cp /etc/php/8.0/fpm/php.ini /etc/php/8.0/cli/.

sed -i 's/;clear_env/clear_env/g' /etc/php/8.0/fpm/pool.d/www.conf

log "Restarting PHP8.0-FPM: " -n
if service php8.0-fpm restart; then log "SUCCESS" -c; else log "FAILURE!" -c; fi

echo
echo -e "${yellow}PHP8.0${NC} Configured!"
