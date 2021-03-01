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

echoLog "spacer"
loadSource "$etcDir/ufw"
echoLog "spacer"
loadSource "$etcDir/nginx"
echoLog "spacer"
loadSource "$etcDir/fcgi"
echoLog "spacer"
loadSource "$etcDir/uwsgi"
echoLog "spacer"
loadSource "$etcDir/mariadb"
echoLog "spacer"
loadSource "$libDir/database"
echoLog "spacer"
loadSource "$etcDir/rkhunter"

echoLog "spacer"
echoLog "${BR3}LEMP Stack${_A} Successfully Installed!"
