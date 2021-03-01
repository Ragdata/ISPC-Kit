#-------------------------------------------------------------------
# src/lib/locale.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         locale.sh
# Author:       Ragdata
# Date:         26/01/2021 0534
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
# handle locale update
if [[ -n ${REGISTRY[LOC]} ]] && [[ ! ${REGISTRY[MODE]} == "test" ]]; then
    echoLog "spacer"
    echoLog "Updating Locale"
    echoLog "line"
    # check current locale
    CURR_LOC=$(locale | awk '/^LANG=/' | awk -F'=' '{print $2}')
    echoLog "Current Locale: $CURR_LOC"
    echoLog "Requested Locale: ${REGISTRY[LOC]}"
    # if current locale != configured locale
    if [[ $CURR_LOC != "${REGISTRY[LOC]}" ]]; then
        if grep -q "^${REGISTRY[LOC]}" < /usr/share/i18n/SUPPORTED; then
            # get the possible alternate form of the locale ID
            if echo "${REGISTRY[LOC]}" | grep -q 'UTF-8$'; then
                LOC_PRE=$(echo "${REGISTRY[LOC]}" | awk -F'.' '{print $1}')
                ALT_LOC="$LOC_PRE.utf8"
            fi
            # check if locale already installed (using alternate form)
            if ! locale -a | grep -q "$ALT_LOC"; then
                locale-gen "${REGISTRY[LOC]}"
                echoLog "Generating locale ${REGISTRY[LOC]}"
            else
                echoLog "Requested locale already installed"
            fi
            # update locale
            echoLog "Performing Update ..."
            dpkg-reconfigure --frontend=noninteractive locales
            update-locale LANG="${REGISTRY[LOC]}"
            echoLog "Performed Update"
            # make sure it sticks
            if grep -q "^export LANG=" < ~/.bashrc; then
                echoLog "Updating ~/.bashrc with new locale settings ... " -n
                sed -i "s/^export LANG=.*/export LANG=\"${REGISTRY[LOC]}\"/" ~/.bashrc
                sed -i "s/^export LANGUAGE=.*/export LANGUAGE=\"${REGISTRY[LOC]}\"/" ~/.bashrc
                sed -i "s/^export LC_ALL=.*/export LC_ALL=\"${REGISTRY[LOC]}\"/" ~/.bashrc
                echoLog "done" -c
            else
                echoLog "Appending locale settings to ~/.bashrc ... " -n
                echo "
# set locale
export LANG=\"${REGISTRY[LOC]}\"
export LANGUAGE=\"${REGISTRY[LOC]}\"
export LC_ALL=\"${REGISTRY[LOC]}\"
" >> ~/.bashrc
                echoLog "done" -c
            fi
            # reload ~/.bashrc
            echoLog "Reloading ~/.bashrc ... " -n
            . ~/.bashrc
            echoLog "done" -c
            # if sudo user has been created, do the same there
            if [[ -d /home/ubuntu ]]; then
                if grep -q "^export LANG=" < /home/ubuntu/.bashrc; then
                    echoLog "Updating /home/ubuntu/.bashrc with new locale settings ..." -n
                    sed -i "s/^export LANG=.*/export LANG=\"${REGISTRY[LOC]}\"/" /home/ubuntu/.bashrc
                    sed -i "s/^export LANGUAGE=.*/export LANGUAGE=\"${REGISTRY[LOC]}\"/" /home/ubuntu/.bashrc
                    sed -i "s/^export LC_ALL=.*/export LC_ALL=\"${REGISTRY[LOC]}\"/" /home/ubuntu/.bashrc
                    echoLog "done" -c
                else
                    echoLog "Appending locale settings to /home/ubuntu/.bashrc ... " -n
                    echo "
# set locale
export LANG=\"${REGISTRY[LOC]}\"
export LANGUAGE=\"${REGISTRY[LOC]}\"
export LC_ALL=\"${REGISTRY[LOC]}\"
" >> /home/ubuntu/.bashrc
                    echoLog "done" -c
                fi
            fi
        else
            echoLog "${BR1}ERROR: Configured locale (${REGISTRY[LOC]}) not supported! Skipping locale update${_A}"
        fi
    else
        echoLog "Locale update not required!"
    fi
fi
locale
