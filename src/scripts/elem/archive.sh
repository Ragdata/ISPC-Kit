#-------------------------------------------------------------------
# src/etc/archive.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         archive.sh
# Author:       Ragdata
# Date:         27/02/2021 0105
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Archival Tools"
echoLog "line"

apt_install arj bzip2 nomarch lzop unzip zip cabextract

echoLog "spacer"
echoLog "${yellow}Archival Tools${NC} Installed Successfully!"
