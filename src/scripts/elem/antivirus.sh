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
echoLog "Installing Antivirus / Antimalware Utilities"
echoLog "spacer"

apt_install amavisd-new spamassassin clamav clamav-daemon clamav-docs

echoLog "spacer"

apt_install libnet-ldap-perl libauthen-sasl-perl libio-string-perl libio-socket-ssl-perl libnet-ident-perl libnet-dns-perl libmail-dkim-perl

echoLog "spacer"

apt_install postgrey razor pyzor

echoLog "spacer"
echoLog "${yellow}Antivirus${NC} Installed Successfully!"

echoLog "Stopping SpamAssassin Service"
echoLog "spacer"

service spamassassin stop
systemctl disable spamassassin

echoLog "spacer"
echoLog "${yellow}SpamAssassing${NC} Stopped Successfully!"
echoLog "spacer"

echoLog "Configuring Antivirus"
echoLog "spacer"

sed -i "s/AllowSupplementaryGroups false/AllowSupplementaryGroups true/" /etc/clamav/clamd.conf
echo "\$myhostname = \"${REGISTRY[FQDN]}\";" >> /etc/amavis/conf.d/05-node_id

echoLog "Updating FreshClam AV Database"
echoLog "spacer"

freshclam

echoLog "Restarting ClamAV"
echoLog "spacer"

if ! service clamav-daemon restart; then errorExit "ANTIVIRUS ERROR: ClamAV failed to restart"; fi

echoLog "spacer"
echoLog "${yellow}DONE${NC}"
