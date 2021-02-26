#-------------------------------------------------------------------
# src/lib/lemp.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         lemp.sh
# Author:       Ragdata
# Date:         26/01/2021 0543
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
clear
echoLog "Installing LEMP Stack"
echoLog "line"

loadSource "$etcDir/ufw"
loadSource "$etcDir/nginx"
loadSource "$etcDir/fcgi"
loadSource "$etcDir/uwsgi"
loadSource "$etcDir/mariadb"
loadSource "$etcDir/rkhunter"

echoLog "spacer"
echoLog "${yellow}LEMP Stack${NC} Successfully Installed!"
