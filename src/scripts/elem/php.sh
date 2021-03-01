#-------------------------------------------------------------------
# src/etc/php.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         php.sh
# Author:       Ragdata
# Date:         24/02/2021 1600
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
# add php repository
if [[ ! -s /etc/apt/sources.list.d/ondrej-ubuntu-php-"$REL".list ]]; then
    echoLog "Adding repository for PHP ... "
    add-apt-repository -y ppa:ondrej/php
    echoLog "${BR3}DONE${_A}"
    apt update
    echoLog "spacer"
fi

loadSource "$etcDir/php72"
echoLog "spacer"
loadSource "$etcDir/php74"
echoLog "spacer"
loadSource "$etcDir/php80"

update-alternatives --set php /usr/bin/php7.4
update-alternatives --set php8 /usr/bin/php8.0
