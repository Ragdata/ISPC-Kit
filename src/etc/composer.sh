#-------------------------------------------------------------------
# src/etc/composer.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         composer.sh
# Author:       Ragdata
# Date:         26/02/2021 0155
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Composer for PHP"
echoLog "line"

apt_install composer

echoLog "spacer"
echoLog "${yellow}Composer${NC} Successfully Installed!"
