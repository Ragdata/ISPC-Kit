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
    echo "Adding repository for PHP ... "
    add-apt-repository -y ppa:ondrej/php
    echo -e "${yellow}DONE${NC}"
    apt update
fi

loadSource "$etcDir/php72"
loadSource "$etcDir/php74"
loadSource "$etcDir/php80"

update-alternatives --set php /usr/bin/php7.4
update-alternatives --set php8 /usr/bin/php8.0
