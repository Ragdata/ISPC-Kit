#-------------------------------------------------------------------
# src/etc/uwsgi.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         uwsgi.sh
# Author:       Ragdata
# Date:         23/02/2021 0638
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing uWSGI ..."
echoLog "spacer"

apt_install uwsgi uwsgi-dev uwsgi-extra uwsgi-plugins-all

echoLog "spacer"
echoLog "${BR3}uWSGI${_A} Successfully Installed!\n"
