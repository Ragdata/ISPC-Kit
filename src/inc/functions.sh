#-------------------------------------------------------------------
# src/inc/functions.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         functions.sh
# Author:       Ragdata
# Date:         26/02/2021 1353
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# LOAD COMMON ELEMENTS
#-------------------------------------------------------------------
source "$baseDir"/src/inc/common.sh
#-------------------------------------------------------------------
# PERFORM COMPATIBILITY CHECKS
#-------------------------------------------------------------------
if [ "${BASH_VERSION:0:1}" -lt 4 ]; then
    echo "ISPC Kit requires a minimum Bash version of 4 - you need to upgrade before you can use this package."
    exit 1
fi
#-------------------------------------------------------------------
# FUNCTIONS
#-------------------------------------------------------------------
apt_install()
{
    hardFail=0

    for pkg in "$@"; do
        if [[ $pkg =~ $isFlag ]]; then
            case "$pkg" in
            "-hardFail") hardFail=1 ;;
            "-noHardFail") hardFail=0 ;;
            "-logTrans") logTrans=1 ;;
            "-noLogTrans") logTrans=0 ;;
            esac
        else
            apt_install_pkg "$pkg" "$logTrans" "$hardFail"
        fi
    done
}

apt_install_pkg()
{
    package=${1:-""}
    logTrans=${2:-0}
    hardFail=${3:-0}

    if [ -z "$package" ]; then errorExit "apt_install_pkg ERROR: Package name not specified!"; fi

    if [[ $logTrans -eq 1 ]] && [[ -f "$LOG" ]]; then
        echoLog "$package: " -n
        if apt install -y "$package"; then
            echoLog "y" -c
        else
            echoLog "n" -c
            if [[ "$hardFail" -eq 1 ]]; then
                exit 1
            fi
        fi
    else
        echo -e "${yellow}Installing $package ...${NC}"
        if apt install -y "$package"; then
            echo -e "${green}DONE!${NC}"
        else
            echo -e "${red}FAIL!${NC}"
            if [[ "$hardFail" -eq 1 ]]; then
                exit 1
            fi
        fi
    fi
}

apt_remove()
{
    logTrans=1

    for pkg in "$@"; do
        if [[ $pkg =~ $isFlag ]]; then
            case "$pkg" in
            "-logTrans") logTrans=1 ;;
            "-noLogTrans") logTrans=0 ;;
            esac
        else
            apt_remove_pkg "$pkg" "$logTrans"
        fi
    done
}

apt_remove_pkg()
{
    package=${1:-""}
    logTrans=${2:-1}

    if [[ $logTrans -eq 1 ]] && [[ -f "$LOG" ]]; then
        echoLog "Removing $package ..."
        if apt purge -y "$package"; then
            echoLog "DONE!"
        else echoLog "FAILED!"; fi
    else
        echo -e "Removing $package ..."
        if apt purge -y "$package"; then
            echo -e "${green}DONE!${NC}"
        else echo -e "${red}FAILED!${NC}"; fi
    fi
}

checkSWAP()
{
    echoLog "Checking available SWAP"

    TOTAL_SWAP=$(awk '/^SwapTotal:/ {print $2}' /proc/meminfo)

    SWAP_MiB=$(( TOTAL_SWAP / 1024))
    SWAP_MB=$(awk -vr=$SWAP_MiB 'BEGIN{printf "%.0f", r * 1.049}')
    SWAP_GiB=$(( SWAP_MB / 1024 ))

    PRINT_SWAP_MiB=$(printf "%'d" $SWAP_MiB)
    PRINT_SWAP_MB=$(printf "%'d" "$SWAP_MB")
    PRINT_SWAP_GiB=$(printf "%'d" $SWAP_GiB)

    echoLog "${yellow}DONE!${NC}"

    echoLog "TOTAL SWAP: $TOTAL_SWAP ($PRINT_SWAP_MiB MiB)"

    # allocate swap space if required and desired
    if [[ $TOTAL_SWAP -lt 4194000 ]] && [[ $flag != "test" ]]; then
        echo
        if [[ $TOTAL_SWAP -gt 0 ]]; then
            echoLog "There is currently $PRINT_SWAP_MiB MiB allocated swap space, but 4GiB is recommended"
        fi
        echo -en "Would you like to allocate 4GiB swap space? $DEFAULT_Y "
        read -n 1 -r
        if [[ $REPLY =~ $AFFIRM ]] || [ -z "$REPLY" ]; then
            echoLog "Attempting to allocate swap space"
            mkSWAP
            # re-test and ensure swapspace available
            TOTAL_SWAP=$(awk '/^SwapTotal:/ {print $2}' /proc/meminfo)
            SWAP_MiB=$(( TOTAL_SWAP / 1024))
            SWAP_MB=$(awk -vr=$SWAP_MiB 'BEGIN{printf "%.0f", r * 1.049}')
            SWAP_GiB=$(( SWAP_MiB / 1024 ))
            PRINT_SWAP_MiB=$(printf "%'d" $SWAP_MiB)
            PRINT_SWAP_MB=$(printf "%'d" "$SWAP_MB")
            PRINT_SWAP_GiB=$(printf "%'d" $SWAP_GiB)
            echoLog "Allocated $PRINT_SWAP_GiB GiB ($PRINT_SWAP_MB MB) swap space"
            echoLog "${yellow}DONE${NC}"
        fi
    fi
}

echoLog()
{
    msg=${1:-""}
    flag=${2:-""}

    if [ -z "$msg" ]; then
        errorExit "ERROR: Corwardly refusing to echo log entry with no message!"
    fi

    if [[ $msg == "spacer" ]]; then
        echo
        log "spacer"
    elif [[ $msg == "line" ]]; then
        echo "======================================================"
        log "line"
    elif [ -n "$flag" ]; then
        if [[ $flag == "-n" ]]; then
            echo -en "$msg"
            log "$msg" -n
        elif [[ $flag == "-c" ]]; then
            echo -e "$msg"
            log "$msg" -c
        fi
    else
        echo -e "$msg"
        log "$msg"
    fi
}

errorExit()
{
    msg=${1:-""}

    if [ -n "$msg" ]; then
        echo -e "${red}$msg${NC}"
        log "$msg"
    fi

    exit 1;
}

getId()
{
    getNetVars
    if [[ ${#IPS[@]} -gt 0 ]]; then
        MATCH=0
        for i in "${!IPS[@]}"
        do
            if [[ ${REGISTRY[IPv4_PUBLIC]} == "${IPS[$i]}" ]]; then
                MATCH=1
                REGISTRY[SERVER_ID]=$i
                break;
            fi
        done
        if [[ $MATCH == 0 ]]; then
            echoLog "${red}ERROR: Unable to match current server IP - ${REGISTRY[IPv4_PUBLIC]}${NC}"
        fi
    else
        REGISTRY[SERVER_ID]="MASTER"
    fi
    if [ -z "${REGISTRY[SERVER_ID]}" ]; then
        REGISTRY[SERVER_ID]="MASTER"
    fi
}

getNetVars()
{
    # check for ifconfig command
    if [[ ! -x /usr/sbin/ifconfig ]]; then
        echoLog "Couldn't find ifconfig command - so installing it now ..."
        apt_install "net-tools"
        echoLog "spacer"
    fi

    echoLog "Determining system network configuration ..."

    REGISTRY[FQDN]=$(hostname -f)

    IFS="." read -r REGISTRY[HOST] REGISTRY[DOMAIN] <<<"${REGISTRY[FQDN]}"

    ifconfig -a | awk '$2~/^flags/{_1=$1;getline;if($1~/^inet/){print _1" "$2}}' >>"$configDir"/.ipv4
    ifconfig -a | awk '$2~/^flags/{_1=$1;getline;getline;getline;if($1~/^inet6/){print _1" "$2}}' >>"$configDir"/.ipv6_private
    ifconfig -a | awk '$2~/^flags/{_1=$1;getline;getline;if($1~/^inet6/){print _1" "$2}}' >>"$configDir"/.ipv6_public

    REGISTRY[IPv4_PUBLIC]=""
    REGISTRY[IPv4_PRIVATE]=""

    while read -r line; do
        IFX=$(echo "$line" | awk -F': ' '{print $1}')
        if [[ $IFX != "lo" ]] && [ -z "${REGISTRY[IPv4_PUBLIC]}" ]; then
            REGISTRY[IF0]="$IFX"
            echoLog "Primary Network Interface: ${REGISTRY[IF0]}"
            REGISTRY[IPv4_PUBLIC]=$(echo "$line" | awk -F': ' '{print $2}')
            echoLog "Public IPv4 Address: ${REGISTRY[IPv4_PUBLIC]}"
        elif [[ $IFX != "lo" ]] && [ -n "${REGISTRY[IPv4_PUBLIC]}" ]; then
            REGISTRY[IF1]="$IFX"
            echoLog "Secondary Network Interface: ${REGISTRY[IF1]}"
            REGISTRY[IPv4_PRIVATE]=$(echo "$line" | awk -F': ' '{print $2}')
            echoLog "Private IPv4 Address: ${REGISTRY[IPv4_PRIVATE]}"
        fi
    done <<<"$(cat "$configDir"/.ipv4)"

    REGISTRY[IPv6_PUBLIC]=""

    while read -r line; do
        IFX=$(echo "$line" | awk -F': ' '{print $1}')
        if [[ $IFX != "lo" ]] && [ -z "${REGISTRY[IPv6_PUBLIC]}" ]; then
            REGISTRY[IPv6_PUBLIC]=$(echo "$line" | awk -F': ' '{print $2}')
            echoLog "Public IPv6 Address discovered on Interface $IFX - ${REGISTRY[IPv6_PUBLIC]}"
        fi
    done <<<"$(cat "$configDir"/.ipv6_public)"

    REGISTRY[IPv6_PRIVATE]=""

    while read -r line; do
        IFX=$(echo "$line" | awk -F': ' '{print $1}')
        if [[ $IFX != "lo" ]] && [ -z "${REGISTRY[IPv6_PRIVATE]}" ]; then
            REGISTRY[IPv6_PRIVATE]=$(echo "$line" | awk -F': ' '{print $2}')
            echoLog "Private IPv6 Address discovered on Interface $IFX - ${REGISTRY[IPv6_PRIVATE]}"
        fi
    done <<<"$(cat "$configDir"/.ipv6_private)"

    REGISTRY[IPv4_GATEWAY]=$(ip route | awk '/default/ {print ($3 == "via") ? $4:$3}')
    if [[ -n "${REGISTRY[IPv4_GATEWAY]}" ]]; then
        echoLog "Found IPv4 Gateway at: ${REGISTRY[IPv4_GATEWAY]}"
    fi
    REGISTRY[IPv6_GATEWAY]=$(ip -6 route | awk '/default/ {print ($3 == "via") ? $4:$3}')
    if [[ -n ${REGISTRY[IPv6_GATEWAY]} ]]; then
        echoLog "Found IPv6 Gateway at: ${REGISTRY[IPv6_GATEWAY]}"
    fi
}

getPassword()
{
    len=${1:-12}

    NUM_REGEX='^.*[0-9]+.*$'
    CAP_REGEX='^.*[A-Z]+.*$'
    SML_REGEX='^.*[a-z]+.*$'
    SYM_REGEX='^[A-Za-z0-9]+[@#$%&_+=][A-Za-z0-9]+$'

    local passwd=""

    while [[ ! $passwd =~ $NUM_REGEX ]] && [[ ! $passwd =~ $CAP_REGEX ]] && [[ ! $passwd =~ $SML_REGEX ]] && [[ ! $passwd =~ $SYM_REGEX ]]; do
        passwd=$(tr </dev/urandom -dc 'A-Za-z0-9@#$%&_+=' | head -c"$len")
    done

    echo "$passwd"
}

initLog()
{
    file=${1:-"install"}

    ext=$(date '+%y%m%d.%I%M')
    LOG="$logDir"/log."$file"."$ext"
    touch "$LOG"
    log "LOG Initialised"
    log "line"
}

loadSource()
{
    filePath=${1:-""}
    override=${2:-""}

    if [ -z "$filePath" ]; then errorExit "loadSource() ERROR: No filePath given!"; fi

    if [[ ! -f "$filePath".sh ]]; then errorExit "loadSource() ERROR: File $filePath.sh not found!"; fi

    file="${filePath##*/}"

    # determine name of array to check for permission
    id="${REGISTRY[SERVER_ID]}"
    key="${file^^}"
    # shellcheck disable=SC1087
    perm="$id[$key]"

    if [[ ${!perm} == 1 ]] || [[ "$override" == "-f" ]]; then
        echoLog "Attempting to load SOURCEFILE: $filePath.sh"
        source "$filePath".sh;
        echoLog "spacer";
    fi
}

log()
{
    msg=${1:-""}
    flag=${2:-""}

    if [ -z "$msg" ]; then
        echo -e "${red}ERROR: Corwardly refusing to write log entry with no message!${NC}"
        echo
        exit 1
    fi

    # shellcheck disable=SC2001
    msg=$( echo "$msg" | sed 's/\\e\[.+m//g' )

    logtime=$(date '+%y-%m-%d:%I%M%S.%3N')

    if [[ $msg == "spacer" ]]; then
        echo " " >>"$LOG"
    elif [[ $msg == "line" ]]; then
        echo "======================================================" >>"$LOG"
    elif [ -n "$flag" ]; then
        if [[ $flag == "-n" ]]; then
            echo -en "$logtime - $msg" >>"$LOG"
        elif [[ $flag == "-c" ]]; then
            echo -e "$msg" >>"$LOG"
        fi
    else
        echo -e "$logtime - $msg" >>"$LOG"
    fi
}

mkSWAP()
{
    swapsize=4
    USED=${PART[-1]%?}

    COMP=$(( PART[1] / 5 ))
    SWAP_MiB=$(( swapsize * 1024 ))
    SWAP_KB=$(( SWAP_MiB * 1049 ))

    if [[ $USED -gt 75 ]] || [[ $COMP -lt $SWAP_KB ]]; then
        errorExit "mkSWAP ERROR: Insufficient space available on primary partition to create required swap space!"
    fi

    echoLog "Allocating $swapsize GiB swap space ... "

    fallocate -l "$swapsize"G /swapfile.sys
    chmod 600 /swapfile.sys
    mkswap /swapfile.sys
    swapon /swapfile.sys

    cp /etc/fstab /etc/fstab.bak

    echo '/swapfile.sys none swap sw 0 0' | tee -a /etc/fstab

    echoLog "${yellow}DONE!${NC}"
}

serverSummary()
{
    clear
    echo -e "********************************************************"
    echo -e "* SERVER SUMMARY                                       *"
    echo -e "********************************************************"
    echo
    echo -e "\tSERVER_ID:\t\t${REGISTRY[SERVER_ID]}"
    echo
    echo -e "\tHostname:\t\t${REGISTRY[HOST]}"
    echo -e "\tHost Domain:\t\t${REGISTRY[DOMAIN]}"
    echo -e "\tHostname FQDN:\t\t${REGISTRY[FQDN]}"
    echo
    echo -e "\tIPv4_PUBLIC:\t\t${REGISTRY[IPv4_PUBLIC]}"
    echo -e "\tIPv4_PRIVATE:\t\t${REGISTRY[IPv4_PRIVATE]}"
    echo
    echo -e "\tIPv4_GATEWAY:\t\t${REGISTRY[IPv4_GATEWAY]}"
    echo
    echo -e "\tIPv6_PUBLIC:\t\t${REGISTRY[IPv6_PUBLIC]}"
    echo -e "\tIPv6_PRIVATE:\t\t${REGISTRY[IPv6_PRIVATE]}"
    echo
    echo -e "\tIPv6_GATEWAY:\t\t${REGISTRY[IPv6_GATEWAY]}"
    echo
    echo -n "Press [ENTER] to continue: "
    read -n 1 -r
}

testOutput()
{
    for key in "${!REGISTRY[@]}"
    do
        echo "$key = ${REGISTRY[$key]}"
    done

    echo -en "Press [ENTER] to continue: "
    read -n 1 -r
}
#-------------------------------------------------------------------
# INITIALISE
#-------------------------------------------------------------------
source "$incDir"/registry.sh
