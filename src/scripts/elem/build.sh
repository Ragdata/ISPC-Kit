#-------------------------------------------------------------------
# src/etc/build.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         build.sh
# Author:       Ragdata
# Date:         26/02/2021 2010
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Build Tools"
echoLog "line"

apt_install zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev
apt_install libffi-dev libgdbm-dev libncurses5-dev automake libtool bison

echoLog "spacer"
echoLog "${yellow}Build Tools${NC} Installed Successfully!"
