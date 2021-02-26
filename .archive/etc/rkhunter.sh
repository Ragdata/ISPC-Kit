#-------------------------------------------------------------------
# src/etc/rkhunter.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         rkhunter.sh
# Author:       Ragdata
# Date:         23/02/2021 0638
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echo "Installing RKHunter ..."
log "spacer"
log "RKHUNTER"
log "line"

apt_install rkhunter

echo
echo -e "${yellow}RKHunter${NC} Successfully Installed!"
echo

echo "Configure RKHunter ..."
log "spacer"
log "Configure RKHunter"

sed -i 's/UPDATE_MIRRORS.*/UPDATE_MIRRORS=1/' /etc/rkhunter.conf
sed -i 's/MIRRORS_MODE.*/MIRRORS_MODE=0/' /etc/rkhunter.conf
sed -i 's/WEB_CMD.*/WEB_CMD=""/' /etc/rkhunter.conf

sed -i 's/CRON_DAILY_RUN.*/CRON_DAILY_RUN="true"/' /etc/default/rkhunter.conf
sed -i 's/CRON_DB_UPDATE.*/CRON_DB_UPDATE="true"/' /etc/default/rkhunter.conf
sed -i 's/APT_AUTOGEN.*/APT_AUTOGEN="true"/' /etc/default/rkhunter.conf

log "Updated /etc/default/rkhunter.conf"

rkhunter --update
log "rkhunter --update"
rkhunter --propupd
log "rkhunter --propupd"

echo
echo -e "${yellow}RKHunter${NC} Successfully Configured!"
