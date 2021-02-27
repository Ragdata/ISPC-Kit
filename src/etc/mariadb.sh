#-------------------------------------------------------------------
# src/etc/mariadb.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         mariadb.sh
# Author:       Ragdata
# Date:         23/02/2021 0638
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing Database Server (MariaDB)"
echoLog "spacer"

echoLog "Purging problematic mysql stubs"
echoLog "spacer"

apt_remove mysql-common

cp -r /etc/mysql /var/lib/mysql ~/
rm -Rf /etc/mysql
rm -Rf /var/lib/mysql

echoLog "spacer"
echoLog "${yellow}DONE${NC}"

PASSWORDS[MYSQL_ROOT]=$(getPassword 16)
echoLog "Set MySQL Root Password Non-Interactively"
echo "mariadb-server mysql-server/root_password password ${PASSWORDS[MYSQL_ROOT]}" | debconf-set-selections
echo "mariadb-server mysql-server/root_password_again password ${PASSWORDS[MYSQL_ROOT]}" | debconf-set-selections
echoLog "Installing MariaDB"
echoLog "spacer"

apt_install mariadb-client mariadb-server

echoLog "spacer"
echoLog "Securing MySQL"

# Make sure nobody can access server without a password
mysql -e "UPDATE mysql.user SET PASSWORD = PASSWORD('${PASSWORDS[MYSQL_ROOT]}') WHERE User = 'root'"
echoLog "Set MySQL root password"
# Kill anonymous users
mysql -e "DELETE FROM mysql.user WHERE User=''"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
log "Removed anonymous user accounts"
# Kill off the demo database
mysql -e "DROP DATABASE IF EXISTS test"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'"
echoLog "Dropped 'Demo' and 'Test' databases"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"

echoLog "spacer"
echoLog "${yellow}DONE${NC}"

sed -i 's/^bind-address/^#bind-address/' /etc/mysql/my.cnf

if [[ ${SERVICES[UFW]} == 1 ]]; then
    if [[ ! -f /etc/default/ufw ]]; then
        echoLog "${yellow}WARNING: UFW is not yet installed! It should have been installed LONG BEFORE NOW!${NC}"
    else
        echoLog "Opening Firewall Ports for MySQL ..."
        echoLog "spacer"

        echoLog "ufw allow 3306/tcp"
        ufw allow 3306/tcp
        echoLog "ufw allow 3306/udp"
        ufw allow 3306/udp

        echoLog "spacer"
        echoLog "${yellow}DONE${NC}"
    fi
fi

echoLog
echoLog "${yellow}MariaDB${NC} Successfully Installed!"
echoLog "spacer"

echoLog "Securing MariaDB ..."
echoLog "spacer"

if [[ ! -d /etc/mysql/ssl ]]; then
    cd /etc/mysql || return 1
    mkdir ssl
    cd ssl || return 1
fi

echoLog "Generating CA Key"
openssl genrsa 2048 > ca-key.pem
echoLog "Generating CA Cert"
if [ -n "${DEFAULTS[SSL_COUNTRY]}" ]; then
    openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem \
        -subj "/C=${DEFAULTS[SSL_COUNTRY]}/ST=${DEFAULTS[SSL_STATE]}/L=${DEFAULTS[SSL_LOCALITY]}/O=${DEFAULTS[SSL_ORGANIZATION]}/OU=${DEFAULTS[SSL_ORGUNIT]}/CN=${REGISTRY[FQDN]}/emailAddress=${DEFAULTS[ADMIN_EMAIL]}"
else
    openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem
fi
echoLog "Generating Server Key"
if [ -n "${DEFAULTS[SSL_COUNTRY]}" ]; then
    openssl req -newkey rsa:2048 -days 365000 -nodes -keyout server-key.pem -out server-req.pem \
        -subj "/C=${DEFAULTS[SSL_COUNTRY]}/ST=${DEFAULTS[SSL_STATE]}/L=${DEFAULTS[SSL_LOCALITY]}/O=${DEFAULTS[SSL_ORGANIZATION]}/OU=${DEFAULTS[SSL_ORGUNIT]}/CN=${REGISTRY[FQDN]}/emailAddress=${DEFAULTS[ADMIN_EMAIL]}"
else
    openssl req -newkey rsa:2048 -days 365000 -nodes -keyout server-key.pem -out server-req.pem
fi
echoLog "Generating Server Certificate"
if [ -n "${DEFAULTS[SSL_COUNTRY]}" ]; then
    openssl x509 -req -in server-req.pem -days 365000 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem \
        -subj "/C=${DEFAULTS[SSL_COUNTRY]}/ST=${DEFAULTS[SSL_STATE]}/L=${DEFAULTS[SSL_LOCALITY]}/O=${DEFAULTS[SSL_ORGANIZATION]}/OU=${DEFAULTS[SSL_ORGUNIT]}/CN=${REGISTRY[FQDN]}/emailAddress=${DEFAULTS[ADMIN_EMAIL]}"
else
    openssl x509 -req -in server-req.pem -days 365000 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem
fi
echoLog "Generating TLS/SSL Certificate"
if [ -n "${DEFAULTS[SSL_COUNTRY]}" ]; then
    openssl req -newkey rsa:2048 -days 365000 -nodes -keyout client-key.pem -out client-req.pem \
        -subj "/C=${DEFAULTS[SSL_COUNTRY]}/ST=${DEFAULTS[SSL_STATE]}/L=${DEFAULTS[SSL_LOCALITY]}/O=${DEFAULTS[SSL_ORGANIZATION]}/OU=${DEFAULTS[SSL_ORGUNIT]}/CN=${REGISTRY[FQDN]}/emailAddress=${DEFAULTS[ADMIN_EMAIL]}"
else
    openssl req -newkey rsa:2048 -days 365000 -nodes -keyout client-key.pem -out client-req.pem
fi
echoLlog "Processing Client RSA"
if [ -n "${DEFAULTS[SSL_COUNTRY]}" ]; then
    openssl rsa -in client-key.pem -out client-key.pem \
        -subj "/C=${DEFAULTS[SSL_COUNTRY]}/ST=${DEFAULTS[SSL_STATE]}/L=${DEFAULTS[SSL_LOCALITY]}/O=${DEFAULTS[SSL_ORGANIZATION]}/OU=${DEFAULTS[SSL_ORGUNIT]}/CN=${REGISTRY[FQDN]}/emailAddress=${DEFAULTS[ADMIN_EMAIL]}"
else
    openssl rsa -in client-key.pem -out client-key.pem
fi
echoLog "Signing the client certificate"
if [ -n "${DEFAULTS[SSL_COUNTRY]}" ]; then
    openssl x509 -req -in client-req.pem -days 365000 -CA ca-cert.pem -set_serial 01 -out client-cert.pem \
        -subj "/C=${DEFAULTS[SSL_COUNTRY]}/ST=${DEFAULTS[SSL_STATE]}/L=${DEFAULTS[SSL_LOCALITY]}/O=${DEFAULTS[SSL_ORGANIZATION]}/OU=${DEFAULTS[SSL_ORGUNIT]}/CN=${REGISTRY[FQDN]}/emailAddress=${DEFAULTS[ADMIN_EMAIL]}"
else
    openssl x509 -req -in client-req.pem -days 365000 -CA ca-cert.pem -set_serial 01 -out client-cert.pem
fi
echoLog "Verify certificates"
if [ -n "${DEFAULTS[SSL_COUNTRY]}" ]; then
    openssl verify -CAfile ca-cert.pem server-cert.pem client-cert.pem \
        -subj "/C=${DEFAULTS[SSL_COUNTRY]}/ST=${DEFAULTS[SSL_STATE]}/L=${DEFAULTS[SSL_LOCALITY]}/O=${DEFAULTS[SSL_ORGANIZATION]}/OU=${DEFAULTS[SSL_ORGUNIT]}/CN=${REGISTRY[FQDN]}/emailAddress=${DEFAULTS[ADMIN_EMAIL]}"
else
    openssl verify -CAfile ca-cert.pem server-cert.pem client-cert.pem
fi
echoLog "Certificates Finalised!"

echoLog "spacer"
echoLog "${yellow}MariaDB${NC} Successfully Installed, but requires post-installation attention"


#echoLog "MariaDB requires post-installation attention"
#pico /etc/mysql/mariadb.conf.d/50-server.cnf
