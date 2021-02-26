#-------------------------------------------------------------------
# src/etc/ufw.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         ufw.sh
# Author:       Ragdata
# Date:         23/02/2021 0638
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
echoLog "Installing Firewall (UFW)"
echoLog "spacer"

apt_install ufw

echoLog "spacer"
echoLog "${yellow}UFW${NC} Successfully Installed!"
echoLog "spacer"

echoLog "Configuring UFW"
echoLog "spacer"

sed -i "s/^IPV6=.*/IPV6=yes/" /etc/default/ufw

ufw default deny incoming
ufw default allow outgoing

log "ufw allow ssh : 22"
ufw allow 22/tcp

echoLog
echoLog "${yellow}DONE!${NC}"
