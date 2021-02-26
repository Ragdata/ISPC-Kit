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
echo "Installing Firewall (UFW) ..."
log "spacer"
log "FIREWALL (UFW)"
log "line"

apt_install ufw

echo
echo -e "${yellow}UFW${NC} Successfully Installed!"
echo

echo "Configuring UFW ... "
log "spacer"
log "Configuring UFW"
log "line"
echo

sed -i "s/^IPV6=.*/IPV6=yes/" /etc/default/ufw

ufw default deny incoming
ufw default allow outgoing

log "ufw allow ssh : 22"
ufw allow 22/tcp

echo
echo -e "${yellow}DONE!${NC}"
