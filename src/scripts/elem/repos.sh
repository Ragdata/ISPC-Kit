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
echoLog "Adding Package Repositories"
echoLog "spacer"

# determine name of permissions array
id="${REGISTRY[SERVER_ID]}"
# determine name of default permission
default="${REGISTRY[SERVER_ID]}_DEFAULT"


# shellcheck disable=SC1087
php="$id[PHP]"
# shellcheck disable=SC1087
python="$id[PYTHON]"
# shellcheck disable=SC1087
nginx="$id[NGINX]"
# shellcheck disable=SC1087
yarn="$id[NODE]"
# shellcheck disable=SC1087
erlang="$id[RABBITMQ]"
# shellcheck disable=SC1087
pushbullet="$id[PUSHBULLET]"
# shellcheck disable=SC1087
gluu="$id[GLUU]"
# shellcheck disable=SC1087
metronome="$id[METRONOME]"

if [[ ${!php} == 1 || ( -z ${!php} && $default == 1 ) ]]; then
    # add php repository
    if [[ ! -s /etc/apt/sources.list.d/ondrej-ubuntu-php-"$REL".list ]]; then
        echo "Adding repository for PHP ... "
        add-apt-repository -y ppa:ondrej/php
        echo -e "${BR3}DONE${_A}"
    fi
fi

if [[ ${!python} == 1 || ( -z ${!python} && $default == 1 ) ]]; then
    # add python repository
    if [[ ! -s /etc/apt/sources.list.d/deadsnakes-ubuntu-ppa-"$REL".list ]]; then
        echo "Adding repository for Python ... "
        add-apt-repository -y ppa:deadsnakes/ppa
        echo -e "${BR3}DONE${_A}"
    fi
fi

if [[ ${!nginx} == 1 || ( -z ${!nginx} && $default == 1 ) ]]; then
    # add nginx repository
    if [[ ! -s /etc/apt/sources.list.d/ondrej-ubuntu-nginx-"$REL".list ]]; then
        echo "Adding repository for Nginx ... "
        add-apt-repository -y ppa:ondrej/nginx
        echo -e "${BR3}DONE${_A}"
    fi
fi

if [[ ${!yarn} == 1 || ( -z ${!yarn} && $default == 1 ) ]]; then
    # add yarn repository
    if [[ ! -f /etc/apt/sources.list.d/yarn.list ]]; then
        echo "Adding repository for Yarn ... "
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
        echo -e "${BR3}DONE${_A}"
    fi
fi

if [[ ${!erlang} == 1 || ( -z ${!erlang} && $default == 1 ) ]]; then
    # add erlang repository
    if [[ ! -f /etc/apt/sources.list.d/erlang.list ]]; then
        echo "Adding repository for Erlang ... "
        wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | apt-key add -
        echo "deb https://packages.erlang-solutions.com/ubuntu \"$REL\" contrib" | tee /etc/apt/sources.list.d/erlang.list
        echo -e "${BR3}DONE${_A}"
    fi
    # add rabbitmq repository
    if [[ ! -f /etc/apt/sources.list.d/rabbitmq.list ]]; then
        echo "Adding repository for RabbitMQ ... "
        wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | apt-key add -
        wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add -
        echo "deb https://dl.bintray.com/rabbitmq-erlang/debian \"$REL\" erlang-22.x" | tee /etc/apt/sources.list.d/rabbitmq.list
        echo -e "${BR3}DONE${_A}"
    fi
fi

if [[ ${!pushbullet} == 1 || ( -z ${!pushbullet} && $default == 1 ) ]]; then
    # add pushbullet repository
    if [[ ! -f /etc/apt/sources.list.d/atareao-ubuntu-atareao-"$REL".list ]]; then
        echo "Adding repository for Pushbullet ... "
        add-apt-repository -y ppa:atareao/atareao
        echo -e "${BR3}DONE${_A}"
    fi
fi

if [[ ${!gluu} == 1 || ( -z ${!gluu} && $default == 1 ) ]]; then
    # add gluu repository
    if [[ ! -f /etc/apt/sources.list.d/gluu-repo.list ]]; then
        echo "Adding repository for Gluu ... "
        echo "deb https://repo.gluu.org/ubuntu/ \"$REL\" main" > /etc/apt/sources.list.d/gluu-repo.list
        curl https://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add -
        echo -e "${BR3}DONE${_A}"
    fi
fi

if [[ ${!metronome} == 1 || ( -z ${!metronome} && $default == 1 ) ]]; then
    # add metronome repository
    if [[ ! -f /etc/apt/sources.list.d/metronome.list ]]; then
        echo "Adding Prosody Package Repository to Sources ... "
        echo "deb http://packages.prosody.im/debian jessie main" > /etc/apt/sources.list.d/metronome.list
        wget http://prosody.im/files/prosody-debian-packages.key -O - | apt-key add -
        echo -e "${BR3}Prosody${_A} Successfully Added!"
    fi
fi

## add caddy repository -- WHY IS THIS HERE??
#if [[ ! -f /etc/apt/sources.list.d/caddy-fury.list ]]; then
#    echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" | sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
#fi

# apt update && upgrade
apt update
apt upgrade -y
apt autoremove -y

echo
echo -e "${BR3}DONE${_A}"
