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
echo "Installing FCGI ..."
log "spacer"
log "FCGI"
log "line"
echo

apt_install fcgiwrap

echo
echo -e "${yellow}FCGI${NC} Successfully Installed!\n"
