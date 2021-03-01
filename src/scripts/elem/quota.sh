#-------------------------------------------------------------------
# src/etc/quota.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         quota.sh
# Author:       Ragdata
# Date:         23/02/2021 1453
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing Quota"
echoLog "spacer"

apt_install quota quotatool

echoLog "spacer"

echoLog "spacer"
echoLog "${BR3}Quota${_A} Successfully Installed!"
echoLog "spacer"

if ! [ -f /proc/user_beancounters ]; then
    echoLog "Initialising Quota, this may take a while"
    echoLog "spacer"

    if [ "$(grep -c ',usrjquota=quota.user,grpjquota=quota.group,jqfmt=vfsv0' /etc/fstab)" -eq 0 ]; then
        sed -i '/\/[[:space:]]\+/ {/tmpfs/!s/errors=remount-ro/errors=remount-ro,usrjquota=quota.user,grpjquota=quota.group,jqfmt=vfsv0/}' /etc/fstab
        sed -i '/\/[[:space:]]\+/ {/tmpfs/!s/defaults/defaults,usrjquota=quota.user,grpjquota=quota.group,jqfmt=vfsv0/}' /etc/fstab
    fi

    echoLog "spacer"
    echoLog "Remounting Filesystem with Quotas Applied"

    if ! mount -o remount /; then errorExit "QUOTA ERROR: Failed to mount modified filesystem"; fi
    quotacheck -avugm
    quotaon -avug

    echoLog "spacer"
    echoLog "${BR3}Quota${_A} Successfully Applied!"
fi
