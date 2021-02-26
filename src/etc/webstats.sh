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
echoLog "Installing Webstats ..."
echoLog "spacer"

apt_install vlogger webalizer awstats geoip-database libclass-dbi-mysql-perl

echoLog "spacer"

sed -i 's/^/#/' /etc/cron.d/awstats

echoLog "spacer"
echoLog "${yellow}Webstats${NC} Successfully Installed!"
