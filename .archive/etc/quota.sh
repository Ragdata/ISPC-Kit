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
echo "Installing Quota ..."
log "spacer"
log "QUOTA"
log "line"
echo

apt_install quota quotatool

log "spacer"

echo
echo -e "${yellow}Quota${NC} Successfully Installed!"
echo

if ! [ -f /proc/user_beancounters ]; then
    echo "Initialising Quota, this may take a while ... "
    log "Initialising Quota"
    echo
    if [ "$(grep -c ',usrjquota=quota.user,grpjquota=quota.group,jqfmt=vfsv0' /etc/fstab)" -eq 0 ]; then
        sed -i '/\/[[:space:]]\+/ {/tmpfs/!s/errors=remount-ro/errors=remount-ro,usrjquota=quota.user,grpjquota=quota.group,jqfmt=vfsv0/}' /etc/fstab
        sed -i '/\/[[:space:]]\+/ {/tmpfs/!s/defaults/defaults,usrjquota=quota.user,grpjquota=quota.group,jqfmt=vfsv0/}' /etc/fstab
    fi
    echo
    echo "Remounting Filesystem with Quotas Applied ... "
    log "Remounting File System"
    echo
    if ! mount -o remount /; then errorExit "QUOTA ERROR: Failed to mount modified filesystem"; fi
    quotacheck -avugm
    quotaon -avug
    echo
    echo -e "${yellow}Quota${NC} Successfully Applied!"
fi
