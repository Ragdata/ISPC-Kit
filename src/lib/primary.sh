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

loadSource "$etcDir/postfix"
loadSource "$etcDir/dovecot"
loadSource "$etcDir/antivirus"
loadSource "$etcDir/pure-ftpd"
loadSource "$etcDir/fail2ban"
loadSource "$etcDir/bind9"
loadSource "$etcDir/quota"
loadSource "$etcDir/jailkit"
loadSource "$etcDir/webstats"
loadSource "$etcDir/mailman"

echoLog
echoLog "${yellow}Primary Services${NC} Successfully Installed!"
