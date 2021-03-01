#-------------------------------------------------------------------
# src/etc/certbot.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         certbot.sh
# Author:       Ragdata
# Date:         27/02/2021 0114
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Let's Encrypt Certbot"
echoLog "line"

apt_install certbot python3-certbot-nginx

echoLog "spacer"
echoLog "${yellow}Let's Encrypt Certbot${NC} Successfully Installed!"
