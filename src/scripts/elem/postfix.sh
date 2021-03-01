#-------------------------------------------------------------------
# src/etc/postfix.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         postfix.sh
# Author:       Ragdata
# Date:         23/02/2021 1446
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
if [[ -f /etc/init.d/sendmail ]]; then
    echo "Removing Sendmail ..."
    echo
    service sendmail stop
    update rc.d -f sendmail remove
    apt_remove sendmail
    echo
    log "spacer"
    echo "${yellow}DONE${NC}"
fi

echo "Installing Postfix SMTP Server ..."
log "spacer"
log "SMTP SERVER"
log "line"
echo

echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string ${REGISTRY[FQDN]}" | debconf-set-selections

apt_install postfix postfix-mysql postfix-doc getmail4

echo
echo -e "${yellow}Postfix${NC} Installed Successfully"
echo

log "spacer"
log "Configuring Postfix SMTP Server"
echo "Configuring Postfix SMTP Server ..."
echo

sed -i "s/#submission inet n       -       y       -       -       smtpd/submission inet n       -       -       -       -       smtpd/" /etc/postfix/master.cf
sed -i "s/#  -o syslog_name=postfix\/submission/  -o syslog_name=postfix\/submission/" /etc/postfix/master.cf
sed -i "s/#  -o smtpd_tls_security_level=encrypt/  -o smtpd_tls_security_level=encrypt/" /etc/postfix/master.cf
sed -i "s/#  -o smtpd_sasl_auth_enable=yes/  -o smtpd_sasl_auth_enable=yes\\$(echo -e '\n\r')  -o smtpd_client_restrictions=permit_sasl_authenticated,reject/" /etc/postfix/master.cf
sed -i "s/#smtps     inet  n       -       y       -       -       smtpd/smtps     inet  n       -       -       -       -       smtpd/" /etc/postfix/master.cf
sed -i "s/#  -o syslog_name=postfix\/smtps/  -o syslog_name=postfix\/smtps/" /etc/postfix/master.cf
sed -i "s/#  -o smtpd_tls_wrappermode=yes/  -o smtpd_tls_wrappermode=yes/" /etc/postfix/master.cf
sed -i "s/#  -o smtpd_sasl_auth_enable=yes/  -o smtpd_sasl_auth_enable=yes\\$(echo -e '\n\r')  -o smtpd_client_restrictions=permit_sasl_authenticated,reject/" /etc/postfix/master.cf
sed -i "s/#tlsproxy  unix  -       -       y       -       0       tlsproxy/tlsproxy  unix  -       -       y       -       0       tlsproxy/" /etc/postfix/master.cf

echo
echo -e "${yellow}DONE${NC}"
echo

id="${REGISTRY[SERVER_ID]}"
# shellcheck disable=SC1087
ufw="$id[UFW]"

if [[ ${!ufw} == 1 ]]; then
    if [[ ! -f /etc/default/ufw ]]; then
        echo -e "${yellow}WARNING: UFW is not yet installed! It should have been installed BEFORE this package!${NC}"
    else
        echo "Opening Firewall Ports for SMTP/SMTPS ... "
        log "Opening Firewall Ports for SMTP/SMTPS"
        echo

        log "ufw allow smtp : 25"
        ufw allow 25/tcp
        log "ufw allow smtps : 465"
        ufw allow 465/tcp
        log "ufw allow submission: 587"
        ufw allow 587/tcp

        #ufw enable

        echo
        echo -e "${yellow}DONE!${NC}"
    fi
fi

if ! service postfix restart; then errorExit "POSTFIX ERROR: Postfix failed to restart"; fi
