#-------------------------------------------------------------------
# src/etc/bind9.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         bind9.sh
# Author:       Ragdata
# Date:         23/02/2021 1453
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echo "Installing DNS Server (Bind9) ..."
log "spacer"
log "DNS SERVER (Bind9)"
log "line"
echo

apt_install bind9 dnsutils haveged resolvconf

echo
echo -e "${green}Bind9${NC} Successfully Installed!"
