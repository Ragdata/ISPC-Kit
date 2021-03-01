#-------------------------------------------------------------------
# src/etc/snapd.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         snapd.sh
# Author:       Ragdata
# Date:         27/02/2021 0114
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Snapd"
echoLog "line"

apt_install snapd

echoLog "spacer"
echoLog "${BR3}Snapd${_A} Successfully Installed!"
