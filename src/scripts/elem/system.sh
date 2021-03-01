#-------------------------------------------------------------------
# src/etc/system.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         system.sh
# Author:       Ragdata
# Date:         26/02/2021 2010
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "System Services"
echoLog "line"
echoLog "spacer"

apt_install daemon git gnupg2 php-cli curl php-pear libsqlite3-dev sqlite3 mcrypt

echoLog "spacer"
echoLog "${BR3}System Services${_A} Installed Successfully!"
