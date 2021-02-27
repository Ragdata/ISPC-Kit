#-------------------------------------------------------------------
# src/lib/primary.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         primary.sh
# Author:       Ragdata
# Date:         26/01/2021 0035
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
clear
echoLog "Installing Primary Services ..."
echoLog "line"

echoLog "spacer"
loadSource "$etcDir/postfix"
echoLog "spacer"
loadSource "$etcDir/dovecot"
echoLog "spacer"
loadSource "$etcDir/antivirus"
echoLog "spacer"
loadSource "$etcDir/pure-ftpd"
echoLog "spacer"
loadSource "$etcDir/fail2ban"
echoLog "spacer"
loadSource "$etcDir/bind9"
echoLog "spacer"
loadSource "$etcDir/quota"
echoLog "spacer"
loadSource "$etcDir/jailkit"
echoLog "spacer"
loadSource "$etcDir/webstats"
echoLog "spacer"
loadSource "$etcDir/mailman"
echoLog "spacer"

echoLog
echoLog "${yellow}Primary Services${NC} Successfully Installed!"
