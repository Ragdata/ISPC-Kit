#-------------------------------------------------------------------
# src/etc/webstats.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         webstats.sh
# Author:       Ragdata
# Date:         23/02/2021 1454
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echo "Installing Webstats ..."
log "spacer"
log "WEBSTATS"
log "line"
echo

apt_install vlogger webalizer awstats geoip-database libclass-dbi-mysql-perl

log "spacer"

sed -i 's/^/#/' /etc/cron.d/awstats
echo
echo -e "${yellow}Webstats${NC} Successfully Installed!"
