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
echo "Uninstalling Apache ..."
log "spacer"
log "UNINSTALL APACHE"
log "line"
echo

service apache2 stop
update-rc.d -f apache2 remove

echo -e "${yellow}DONE!${NC}"
log "DONE"
echo

echo "Installing Nginx ..."
log "spacer"
log "NGINX"
log "line"
echo

apt_install nginx-full

rm -f /etc/nginx/nginx.conf

if [ ! -d "$NGINXCONFIG" ]; then
    mkdir "$NGINXCONFIG"
fi

cp "$configDir"/nginx/nginx.conf /etc/nginx/.
cp "$configDir"/nginx/nginxconfig.io/* /etc/nginx/nginxconfig.io/.
cp "$configDir"/nginx/sites-available/example.com.conf /etc/nginx/sites-available/.
cp "$configDir"/nginx/sites-available/example.com.80.conf /etc/nginx/sites-available/.

if [ ! -f /etc/nginx/dhparam.pem ]; then
    cd /etc/nginx || exit 1
    openssl dhparam -out dhparam.pem 2048
    cd - || exit 1
fi

log "Testing Nginx Config ... " -n
if nginx -t; then log "SUCCESS!" -c; else log "FAILURE!" -c; echo -e "${red}ERROR: Nginx failed config test${NC}"; fi

log "Restarting Nginx ... " -n
if service nginx restart; then log "SUCCESS!" -c; else log "FAILURE!" -c; fi

if [[ ${SERVICES[UFW]} == 1 ]]; then
    if [[ ! -f /etc/default/ufw ]]; then
        echo -e "${yellow}WARNING: UFW is not yet installed! It should have been installed BEFORE this package!${NC}"
    else
        echo "Opening Firewall Ports for HTTP/HTTPS ... "
        log "Opening Firewall Ports for HTTP/HTTPS"
        echo

        log "ufw allow http : 80"
        ufw allow 80/tcp
        log "ufw allow https : 443"
        ufw allow 443/tcp

        echo
        echo -e "${yellow}DONE!${NC}"
    fi
fi

echo
echo -e "${yellow}Nginx${NC} Successfully Installed!\n"
