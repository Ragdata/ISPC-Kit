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
echo "Installing uWSGI ..."
log "spacer"
log "uWSGI"
log "line"
echo

apt_install uwsgi uwsgi-dev uwsgi-extra uwsgi-plugins-all

echo
echo -e "${yellow}uWSGI${NC} Successfully Installed!\n"
