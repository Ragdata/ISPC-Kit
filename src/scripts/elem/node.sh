#-------------------------------------------------------------------
# src/etc/node.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         node.sh
# Author:       Ragdata
# Date:         27/02/2021 0117
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Node.js"
echoLog "line"

apt_install nodejs npm yarn

echoLog "spacer"

echoLog "nvm: " -n
if su -c ubuntu curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash; then echoLog "y" -c; else echoLog "n" -c; fi

echoLog "spacer"
echoLog "${BR3}Node.js + Extensions${_A} Successfully Installed!"
