#-------------------------------------------------------------------
# src/etc/nginx.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         nginx.sh
# Author:       Ragdata
# Date:         23/02/2021 0638
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# COMMON
#-------------------------------------------------------------------
NGINXCONFIG="/etc/nginx/nginxconfig.io"
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Uninstalling Apache"
echoLog "spacer"

service apache2 stop
update-rc.d -f apache2 remove

echoLog "${BR3}DONE!${_A}"
echoLog "spacer"

echoLog "Installing Nginx"
echoLog "spacer"

apt_install nginx-full

echoLog "spacer"
echoLog "${BR3}Nginx${_A} Successfully Installed!"

echoLog "spacer"
echoLog "Configuring Nginx"
echoLog "spacer"

rm -f /etc/nginx/nginx.conf
echoLog "Creating nginxconfig.io"
if [ ! -d "$NGINXCONFIG" ]; then
    mkdir "$NGINXCONFIG"
fi
echoLog "Copying ISCP-Kit Config files to Nginx"
cp "$configDir"/nginx/nginx.conf /etc/nginx/.
cp "$configDir"/nginx/nginxconfig.io/* /etc/nginx/nginxconfig.io/.
cp "$configDir"/nginx/sites-available/example.com.conf /etc/nginx/sites-available/.
cp "$configDir"/nginx/sites-available/example.com.80.conf /etc/nginx/sites-available/.

if [ ! -f /etc/nginx/dhparam.pem ]; then
    echoLog "Creating dhparam - this could take a while"
    cd /etc/nginx || return 1
    openssl dhparam -out dhparam.pem 2048
    cd - || return 1
fi

echoLog "Testing Nginx Config ... " -n
if nginx -t; then echoLog "SUCCESS!" -c; else echoLog "FAILURE!" -c; echo -e "${BR1}ERROR: Nginx failed config test${_A}"; fi

echoLog "Restarting Nginx ... " -n
if service nginx restart; then echoLog "SUCCESS!" -c; else echoLog "FAILURE!" -c; fi

id="${REGISTRY[SERVER_ID]}"
# shellcheck disable=SC1087
ufw="$id[UFW]"

if [[ ${!ufw} == 1 ]]; then
    if [[ ! -f /etc/default/ufw ]]; then
        echoLog "${BR3}WARNING: UFW is not yet installed! It should have been installed BEFORE this package!${_A}"
    else
        echoLog "Opening Firewall Ports for HTTP/HTTPS ... "
        echoLog "spacer"
        echoLog "ufw allow http : 80"
        ufw allow 80/tcp
        echoLog "ufw allow https : 443"
        ufw allow 443/tcp

        echoLog "spacer"
        echoLog "${BR3}DONE!${_A}"
    fi
fi

echoLog "spacer"
echoLog "${BR3}Nginx${_A} Successfully Installed!\n"
