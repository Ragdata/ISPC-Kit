#-------------------------------------------------------------------
# src/etc/telegram.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         telegram.sh
# Author:       Ragdata
# Date:         26/02/2021 0155
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Telegram Command-Line Client"
echoLog "line"

apt_install telegram-cli

echoLog
echoLog "${yellow}Telegram-CLI${NC} Successfully Installed!"
