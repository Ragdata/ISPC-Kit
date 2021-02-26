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

loadSource "$etcDir/system"
echoLog "spacer"
loadSource "$etcDir/build"
echoLog "spacer"


echoLog "Archival Tools"
echoLog "line"

apt_install arj bzip2 nomarch lzop unzip zip cabextract

echoLog "spacer"


echoLog "APT Tools"
echoLog "line"

apt_install debconf-utils binutils apt-transport-https apt-listchanges

echoLog "spacer"
echoLog "${yellow}Basic Services${NC} Installed Successfully!"

echoLog "spacer"


echoLog "Python 3 Extensions"
echoLog "line"

apt_install software-properties-common python3-software-properties python3-dev python3-dateutil python3-debconf
apt_install python3-debian python3-pip python3-venv python3-django

echoLog "spacer"

cd /usr/bin || exit 1

ln -s pip3 pip

cd - || exit 1

echoLog "virtualenvwrapper: " -n
if pip install virtualenvwrapper; then echoLog "y" -c; else echoLog "n" -c; fi

echoLog "spacer"
echoLog "${yellow}Python3 Extensions${NC} Successfully Installed!"

echoLog "spacer"


echoLog "Let's Encrypt Certbot"
echoLog "line"

apt_install certbot python3-certbot-nginx

echoLog "spacer"
echoLog "${yellow}Let's Encrypt Certbot${NC} Successfully Installed!"

echoLog "spacer"


echoLog "Snapd"
echoLog "line"

apt_install snapd

echoLog "spacer"
echoLog "${yellow}Snapd${NC} Successfully Installed!"

echoLog "spacer"


echoLog "Perl 5 + Extensions ..."
echoLog "line"

apt_install perl perl-openssl-defaults perl-doc libterm-readline-gnu-perl libdbi-perl libdbd-mysql-perl
apt_install libsql-statement-perl libclone-perl libmldbm-perl libnet-daemon-perl

echoLog "spacer"
echoLog "${yellow}Perl 5 + Extensions${NC} Successfully Installed!"

echoLog "spacer"


echoLog "Node.js"
echoLog "line"

apt_install nodejs npm yarn

echoLog "spacer"

echoLog "nvm: " -n
if su -c ubuntu curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash; then echoLog "y" -c; else echoLog "n" -c; fi

echoLog "spacer"
echoLog "${yellow}Node.js + Extensions${NC} Successfully Installed!"

loadSource "$etcDir/ruby"
loadSource "$etcDir/php"

echoLog "spacer"


echoLog "Composer for PHP"
echoLog "line"

apt_install composer

echoLog "spacer"
echoLog "${yellow}Composer${NC} Successfully Installed!"

echoLog "spacer"


echoLog "Media Extras"
echoLog "line"

apt_install ffmpeg smbclient supervisor libmagickcore-6.q16-3-extra

echoLog "spacer"
echoLog "${yellow}Media Extras${NC} Successfully Installed!"

echoLog "spacer"


echoLog "Telegram Command-Line Client"
echoLog "line"

apt_install telegram-cli

echoLog
echoLog "${yellow}Telegram-CLI${NC} Successfully Installed!"

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
