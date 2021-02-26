#-------------------------------------------------------------------
# src/etc/user.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         user.sh
# Author:       Ragdata
# Date:         26/01/2021 0035
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
if [[ ! -d /home/ubuntu ]]; then
    adduser ubuntu
    usermod -aG sudo ubuntu

    echo -n "Enter name of SSH Key registered with GitHub or 'none' to skip: "
    read -r keyname
    echo
    if [ -n "$keyname" ] && [[ $keyname != "none" ]]; then
        echo "Paste PUBLIC Key (hit ctl-d when done):"
        echo
        pubkey=$(</dev/stdin)
        echo
        echo "Paste PRIVATE Key (hit ctl-d when done):"
        echo
        privkey=$(</dev/stdin)
        echo
        echo -n "Installing GIT Keys ... "
        if [[ ! -d ~/.ssh ]]; then
            mkdir ~/.ssh
        fi
        echo "$pubkey" >> ~/.ssh/"$keyname".pub
        echo "$privkey" >> ~/.ssh/"$keyname"
        chmod 600 ~/.ssh/"$keyname"
        echo -e "${yellow}DONE${NC}"
    fi

    rsync --archive --chown=ubuntu:ubuntu ~/.ssh /home/ubuntu

    sed -i "s/^PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config

    { echo ""; echo "# authorised users"; echo "AllowUsers ubuntu"; } >> /etc/ssh/sshd_config

    service ssh restart

    { echo ""; echo "# ssh-agent"; } >> ~/.bashrc
    { echo ""; echo "# ssh-agent"; } >> /home/ubuntu/.bashrc
    { echo "eval \$(ssh-agent)"; echo "ssh-add ~/.ssh/$keyname"; } >> ~/.bashrc
    { echo "eval \$(ssh-agent)"; echo "ssh-add ~/.ssh/$keyname"; } >> /home/ubuntu/.bashrc
fi