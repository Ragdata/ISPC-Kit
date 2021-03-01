#-------------------------------------------------------------------
# src/lib/basics.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         basics.sh
# Author:       Ragdata
# Date:         26/01/2021 0034
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
clear

echoLog "spacer"
loadSource "$etcDir/system"
echoLog "spacer"
loadSource "$etcDir/build"
echoLog "spacer"
loadSource "$etcDir/archive"
echoLog "spacer"
loadSource "$etcDir/apt"
echoLog "spacer"
loadSource "$etcDir/python"
0echoLog "spacer"
loadSource "$etcDir/certbot"
echoLog "spacer"
loadSource "$etcDir/snapd"
echoLog "spacer"
loadSource "$etcDir/perl"
echoLog "spacer"
loadSource "$etcDir/ruby"
echoLog "spacer"
loadSource "$etcDir/php"
echoLog "spacer"
loadSource "$etcDir/composer"
echoLog "spacer"
loadSource "$etcDir/multimedia"
echoLog "spacer"
loadSource "$etcDir/telegram"
echoLog "spacer"

# Change default shell from Dash to Bash
if [ /bin/sh -ef /bin/dash ]; then
    echoLog "spacer"
    echoLog "Changing default shell from dash to bash"
    echo "dash dash/sh boolean false" | debconf-set-selections
    dpkg-reconfigure -f noninteractive dash > /dev/null 2>&1
    echoLog "${yellow}DONE${NC}"
fi

echoLog "spacer"
echoLog "${yellow}Basic Services${NC} Successfully Installed!"
