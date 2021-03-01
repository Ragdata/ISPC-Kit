#-------------------------------------------------------------------
# src/etc/fcgi.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         fcgi.sh
# Author:       Ragdata
# Date:         23/02/2021 0638
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing FCGI"
echoLog "spacer"

apt_install fcgiwrap

echoLog "spacer"
echoLog "${BR3}FCGI${_A} Successfully Installed!\n"
