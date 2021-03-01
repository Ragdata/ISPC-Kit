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
echoLog "Installing RKHunter"
echoLog "spacer"

apt_install rkhunter

echoLog "spacer"
echoLog "${BR3}RKHunter${_A} Successfully Installed!"
echoLog "spacer"

echoLog "Configure RKHunter"
echoLog "spacer"

sed -i 's/UPDATE_MIRRORS.*/UPDATE_MIRRORS=1/' /etc/rkhunter.conf
sed -i 's/MIRRORS_MODE.*/MIRRORS_MODE=0/' /etc/rkhunter.conf
sed -i 's/WEB_CMD.*/WEB_CMD=""/' /etc/rkhunter.conf

sed -i 's/CRON_DAILY_RUN.*/CRON_DAILY_RUN="true"/' /etc/default/rkhunter.conf
sed -i 's/CRON_DB_UPDATE.*/CRON_DB_UPDATE="true"/' /etc/default/rkhunter.conf
sed -i 's/APT_AUTOGEN.*/APT_AUTOGEN="true"/' /etc/default/rkhunter.conf

echoLog "Updated /etc/default/rkhunter.conf"

rkhunter --update
echoLog "rkhunter --update"
rkhunter --propupd
echoLog "rkhunter --propupd"

echoLog "spacer"
echoLog "${BR3}RKHunter${_A} Successfully Configured!"
