#-------------------------------------------------------------------
# src/etc/jailkit.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         jailkit.sh
# Author:       Ragdata
# Date:         23/02/2021 1454
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echo "Installing JailKit ..."
log "spacer"
log "JAILKIT"
log "line"
echo

apt_install jailkit

log "spacer"

echo
echo -e "${yellow}Jailkit${NC} Successfully Installed!"
