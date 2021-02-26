#-------------------------------------------------------------------
# src/lib/init.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         init.sh
# Author:       Ragdata
# Date:         26/01/2021 0035
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
clear
echoLog "Initialising Server"
echoLog "line"

loadSource "$etcDir/user"
echoLog "spacer"
loadSource "$etcDir/repos"

echoLog "spacer"
echoLog "${yellow}Initialisation${NC} Successcul!"
