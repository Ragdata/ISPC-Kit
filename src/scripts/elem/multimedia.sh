#-------------------------------------------------------------------
# src/etc/multimedia.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         multimedia.sh
# Author:       Ragdata
# Date:         26/02/2021 0155
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Multimedia Support"
echoLog "line"

apt_install ffmpeg smbclient supervisor libmagickcore-6.q16-3-extra

echoLog "spacer"
echoLog "${yellow}Multimedia Support${NC} Successfully Installed!"
