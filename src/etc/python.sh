#-------------------------------------------------------------------
# src/etc/python.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         python.sh
# Author:       Ragdata
# Date:         27/02/2021 0107
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Python 3 Extensions"
echoLog "line"

apt_install software-properties-common python3-software-properties python3-dev python3-dateutil python3-debconf
apt_install python3-debian python3-pip python3-venv python3-django

echoLog "spacer"

cd /usr/bin || exit 1

ln -s pip3 pip

cd - || exit 1

echoLog "virtualenvwrapper: " -n
if pip install virtualenvwrapper; then echoLog "y" -c; else echoLog "n" -c; fi

echoLog "spacer"
echoLog "${yellow}Python3 Extensions${NC} Successfully Installed!"
