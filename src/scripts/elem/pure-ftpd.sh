#-------------------------------------------------------------------
# src/etc/pure-ftpd.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         pure-ftpd.sh
# Author:       Ragdata
# Date:         23/02/2021 1447
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing FTP Server (Pure-FTPd)"
echoLog "spacer"

echo "pure-ftpd-common pure-ftpd/virtualchroot boolean true" | debconf-set-selections

apt_install pure-ftpd-common pure-ftpd-mysql

echoLog "spacer"

sed -i 's/ftp/\#ftp/' /etc/inetd.conf
echo 1 > /etc/pure-ftpd/conf/TLS
echo "40110 40210" > /etc/pure-ftpd/conf/PassivePortRange
mkdir -p /etc/ssl/private/
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=$SSL_COUNTRY/ST=$SSL_STATE/L=$SSL_LOCALITY/O=$SSL_ORGANIZATION/OU=$SSL_ORGUNIT/CN=${REGISTRY[FQDN]}"
chmod 600 /etc/ssl/private/pure-ftpd.pem

echoLog "spacer"
echoLog "${BR3}Pure-FTPd${_A} Successfully Installed!"
echoLog "spacer"

echoLog "Restarting FTP Server"
echoLog "spacer"

service openbsd-inetd restart

if ! service pure-ftpd-mysql restart; then errorExit "PURE-FTPd ERROR: Pure-FTPd failed to restart"; fi

id="${REGISTRY[SERVER_ID]}"
# shellcheck disable=SC1087
ufw="$id[UFW]"

if [[ ${!ufw} == 1 ]]; then
    if [[ ! -f /etc/default/ufw ]]; then
        echoLog "${BR3}WARNING: UFW is not yet installed! It should have been installed BEFORE this package!${_A}"
    else
        echoLog "Opening Firewall Ports for FTP/TLS/FTPS"
        echoLog "spacer"

        echoLog "ufw allow ftp : 21"
        ufw allow 21/tcp
        echoLog "ufw allow ftps : 990"
        ufw allow 990/tcp
        echoLog "ufw allow ftps-data: 989"
        ufw allow 989/tcp
        echoLog "ufw allow passive ftp: 40110:40210"
        ufw allow 40110:40210/tcp

        echoLog "spacer"
        echoLog "${BR3}DONE!${_A}"
    fi
fi

echoLog "spacer"
echoLog "${BR3}DONE!${_A}"
