#-------------------------------------------------------------------
# src/etc/apt.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         archive.sh
# Author:       Ragdata
# Date:         27/02/2021 0107
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "APT Tools"
echoLog "line"

apt_install debconf-utils binutils apt-transport-https apt-listchanges

echoLog "spacer"
echoLog "${yellow}APT Tools${NC} Installed Successfully!"
