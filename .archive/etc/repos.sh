#-------------------------------------------------------------------
# src/etc/repos.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         repos.sh
# Author:       Ragdata
# Date:         26/01/2021 0035
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
echo "Adding Package Repositories ... "
log "spacer"
log "REPOSITORIES"
log "line"
echo

# determine name of permissions array
id="${REGISTRY[SERVER_ID]}"

# add php repository
if [[ ! -s /etc/apt/sources.list.d/ondrej-ubuntu-php-"$REL".list ]]; then
    echo "Adding repository for PHP ... "
    add-apt-repository -y ppa:ondrej/php
    echo -e "${yellow}DONE${NC}"
fi

# add python repository
if [[ ! -s /etc/apt/sources.list.d/deadsnakes-ubuntu-ppa-"$REL".list ]]; then
    echo "Adding repository for Python ... "
    add-apt-repository -y ppa:deadsnakes/ppa
    echo -e "${yellow}DONE${NC}"
fi

# add nginx repository
if [[ ! -s /etc/apt/sources.list.d/ondrej-ubuntu-nginx-"$REL".list ]]; then
    echo "Adding repository for Nginx ... "
    add-apt-repository -y ppa:ondrej/nginx
    echo -e "${yellow}DONE${NC}"
fi

# add yarn repository
if [[ ! -f /etc/apt/sources.list.d/yarn.list ]]; then
    echo "Adding repository for Yarn ... "
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
    echo -e "${yellow}DONE${NC}"
fi

# add erlang repository
if [[ ! -f /etc/apt/sources.list.d/erlang.list ]]; then
    echo "Adding repository for Erlang ... "
    wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | apt-key add -
    echo "deb https://packages.erlang-solutions.com/ubuntu \"$REL\" contrib" | tee /etc/apt/sources.list.d/erlang.list
    echo -e "${yellow}DONE${NC}"
fi

# add pushbullet repository
if [[ ! -f /etc/apt/sources.list.d/atareao-ubuntu-atareao-"$REL".list ]]; then
    echo "Adding repository for Pushbullet ... "
    add-apt-repository -y ppa:atareao/atareao
    echo -e "${yellow}DONE${NC}"
fi

# add rabbitmq repository
if [[ ! -f /etc/apt/sources.list.d/rabbitmq.list ]]; then
    echo "Adding repository for RabbitMQ ... "
    wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | apt-key add -
    wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
    echo "deb https://dl.bintray.com/rabbitmq-erlang/debian \"$REL\" erlang-22.x" | tee /etc/apt/sources.list.d/rabbitmq.list
    echo -e "${yellow}DONE${NC}"
fi

# add gluu repository
if [[ ! -f /etc/apt/sources.list.d/gluu-repo.list ]]; then
    echo "Adding repository for Gluu ... "
    echo "deb https://repo.gluu.org/ubuntu/ \"$REL\" main" > /etc/apt/sources.list.d/gluu-repo.list
    curl https://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add -
    echo -e "${yellow}DONE${NC}"
fi

# add metronome repository
if [[ ! -f /etc/apt/sources.list.d/metronome.list ]]; then
    echo "Adding Prosody Package Repository to Sources ... "
    echo "deb http://packages.prosody.im/debian jessie main" > /etc/apt/sources.list.d/metronome.list
    wget http://prosody.im/files/prosody-debian-packages.key -O - | apt-key add -
    echo -e "${yellow}Prosody${NC} Successfully Added!"
fi

# add caddy repository
if [[ ! -f /etc/apt/sources.list.d/caddy-fury.list ]]; then
    echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" | sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
fi

# apt update && upgrade
apt update
apt upgrade -y
apt autoremove -y

echo
echo -e "${yellow}DONE${NC}"
