#-------------------------------------------------------------------
# src/etc/antivirus.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         antivirus.sh
# Author:       Ragdata
# Date:         23/02/2021 1446
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echo "Installing Antivirus / Antimalware Utilities ..."
log "spacer"
log "ANTIVIRUS / ANTIMALWARE"
log "line"
echo

apt_install amavisd-new spamassassin clamav clamav-daemon clamav-docs

log "spacer"

apt_install libnet-ldap-perl libauthen-sasl-perl libio-string-perl libio-socket-ssl-perl libnet-ident-perl libnet-dns-perl libmail-dkim-perl

log "spacer"

apt_install postgrey razor pyzor

log "spacer"

echo
echo -e "${yellow}Antivirus${NC} Installed Successfully!"
echo

echo "Stopping SpamAssassin Service ..."
log "Stopping SpamAssassing"
echo
service spamassassin stop
systemctl disable spamassassin
echo
echo -e "${yellow}SpamAssassing${NC} Stopped Successfully!"
echo

echo "Configuring Antivirus ..."
log "spacer"
log "Configuring Antivirus"
echo

sed -i "s/AllowSupplementaryGroups false/AllowSupplementaryGroups true/" /etc/clamav/clamd.conf
echo "\$myhostname = \"${REGISTRY[FQDN]}\";" >> /etc/amavis/conf.d/05-node_id

echo "Updating FreshClam AV Database ..."
log "spacer"
log "Updating FreshClam AV Database"
echo

freshclam

echo "Restarting ClamAV ..."
log "spacer"
log "Restarting ClamAV"
echo

if ! service clamav-daemon restart; then errorExit "ANTIVIRUS ERROR: ClamAV failed to restart"; fi

echo
echo -e "${yellow}DONE${NC}"
