#-------------------------------------------------------------------
# src/etc/jailkit.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         jailkit.sh
# Author:       Ragdata
# Date:         23/02/2021 1454
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing JailKit ..."
echoLog "spacer"

apt_install jailkit

echoLog "spacer"

echoLog "spacer"
echoLog "${yellow}Jailkit${NC} Successfully Installed!"
