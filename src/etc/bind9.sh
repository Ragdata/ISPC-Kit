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
echoLog "Installing DNS Server (Bind9)"
echoLog "spacer"

apt_install bind9 dnsutils haveged resolvconf

echoLog "spacer"
echoLog "${green}Bind9${NC} Successfully Installed!"
