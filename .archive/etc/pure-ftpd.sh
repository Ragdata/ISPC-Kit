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
echo "Installing FTP Server (Pure-FTPd) ..."
log "spacer"
log "FTP SERVER (Pure-FTPd)"
log "line"
echo

echo "pure-ftpd-common pure-ftpd/virtualchroot boolean true" | debconf-set-selections

apt_install pure-ftpd-common pure-ftpd-mysql

log "spacer"

sed -i 's/ftp/\#ftp/' /etc/inetd.conf
echo 1 > /etc/pure-ftpd/conf/TLS
echo "40110 40210" > /etc/pure-ftpd/conf/PassivePortRange
mkdir -p /etc/ssl/private/
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=$SSL_COUNTRY/ST=$SSL_STATE/L=$SSL_LOCALITY/O=$SSL_ORGANIZATION/OU=$SSL_ORGUNIT/CN=${REGISTRY[FQDN]}"
chmod 600 /etc/ssl/private/pure-ftpd.pem

echo
echo -e "${yellow}Pure-FTPd${NC} Successfully Installed!"
echo

echo "Restarting FTP Server ..."
log "Restarting FTP Server"
echo

service openbsd-inetd restart

if ! service pure-ftpd-mysql restart; then errorExit "PURE-FTPd ERROR: Pure-FTPd failed to restart"; fi

if [[ ! -f /etc/default/ufw ]]; then
    echo -e "${yellow}WARNING: UFW is not yet installed! It should have been installed BEFORE this package!${NC}"
else
    echo "Opening Firewall Ports for FTP/TLS/FTPS ... "
    log "Opening Firewall Ports for FTP/TLS/FTPS"
    echo

    log "ufw allow ftp : 21"
    ufw allow 21/tcp
    log "ufw allow ftps : 990"
    ufw allow 990/tcp
    log "ufw allow ftps-data: 989"
    ufw allow 989/tcp
    log "ufw allow passive ftp: 40110:40210"
    ufw allow 40110:40210/tcp

    echo
    echo -e "${yellow}DONE!${NC}"
fi

echo
echo -e "${yellow}DONE!${NC}"
