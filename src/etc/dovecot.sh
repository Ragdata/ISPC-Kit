#-------------------------------------------------------------------
# src/etc/dovecot.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         dovecot.sh
# Author:       Ragdata
# Date:         23/02/2021 1446
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing Dovecot POP3/IMAP Server and Mail Signing Utilities"
echoLog "spacer"

PASSWORDS[OPENDMARC]=$(getPassword)

echo "dovecot-core dovecot-core/create-ssl-cert boolean false" | debconf-set-selections
echo "dovecot-core dovecot-core/ssl-cert-name string ${REGISTRY[FQDN]}" | debconf-set-selections

echo "opendmarc opendmarc/dbconfig-install boolean false" | debconf-set-selections
echo "opendmarc opendmarc/mysql/admin-pass ${PASSWORDS[MYSQL_ROOT]}" | debconf-set-selections
echo "opendmarc opendmarc/mysql/app-pass ${PASSWORDS[OPENDMARC]}" | debconf-set-selections

apt_install dovecot-imapd dovecot-pop3d dovecot-mysql dovecot-sieve dovecot-lmtpd opendkim opendkim-tools opendmarc

echoLog "spacer"
echoLog "${yellow}Dovecot${NC} Installed Successfully"
echoLog "spacer"

if [[ ! -f /etc/default/ufw ]]; then
    echoLog "${yellow}WARNING: UFW is not yet installed! It should have been installed BEFORE this package!${NC}"
else
    echoLog "Opening Firewall Ports for POP3/IMAP/POP3S/IMAPS"
    echoLog "spacer"

    echoLog "ufw allow pop3 : 110"
    ufw allow 110/tcp
    echoLog "ufw allow pop3s : 995"
    ufw allow 995/tcp
    echoLog "ufw allow imap: 143"
    ufw allow 143/tcp
    echoLog "ufw allow imaps: 993"
    ufw allow 993/tcp

    #ufw enable

    echoLog "spacer"
    echoLog "${yellow}DONE!${NC}"
fi
