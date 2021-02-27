#-------------------------------------------------------------------
# src/lib/ispconfig.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         ispconfig.sh
# Author:       Ragdata
# Date:         26/01/2021 0035
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
clear
echoLog "Installing ISPConfig ..."
echoLog "line"
echoLog "spacer"

cd /tmp || return 1

wget http://www.ispconfig.org/downloads/ISPConfig-3-stable.tar.gz

tar zfx ISPConfig-3-stable.tar.gz

cd - || return 1

cd /tmp/ispconfig3_install/install || return 1

php -q install.php

cd - || return 1

id="${REGISTRY[SERVER_ID]}"
# shellcheck disable=SC1087
ufw="$id[UFW]"

if [[ ${!ufw} == 1 ]]; then
    ufw allow 8080/tcp
    ufw allow 8081/tcp
fi

echoLog "spacer"
echoLog "${yellow}ISPConfig${NC} Successfully Installed!"
echo
echo -e "You can access ISPConfig at:"
echo -e "\t https://${REGISTRY[FQDN]}:8080"
echo -e "You can access the Apps Host at:"
echo -e "\t https://${REGISTRY[FQDN]}:8081"
