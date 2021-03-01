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
    log "Added User ubuntu"
    usermod -aG sudo ubuntu
    log "Added User ubuntu to sudo group"
    echo -n "Enter name of SSH Key registered with GitHub or 'none' to skip: "
    read -r keyname
    echo
    if [ -n "$keyname" ] && [[ $keyname != "none" ]]; then
        log "Collecting Public Key"
        echo "Paste PUBLIC Key (hit ctl-d when done):"
        echo
        pubkey=$(</dev/stdin)
        echo
        log "Collecting Private Key"
        echo "Paste PRIVATE Key (hit ctl-d when done):"
        echo
        privkey=$(</dev/stdin)
        echo
        echoLog "Installing GIT Keys ... " -n
        if [[ ! -d ~/.ssh ]]; then
            mkdir ~/.ssh
        fi
        echo "$pubkey" >> ~/.ssh/"$keyname".pub
        echo "$privkey" >> ~/.ssh/"$keyname"
        chmod 600 ~/.ssh/"$keyname"
        echoLog "${BR3}DONE${_A}" -c
    fi

    rsync --archive --chown=ubuntu:ubuntu ~/.ssh /home/ubuntu
    echoLog "Sync new user .ssh directory with root .ssh directory"
    sed -i "s/^PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
    echoLog "Restricted root SSH login"
    { echo ""; echo "# authorised users"; echo "AllowUsers ubuntu"; } >> /etc/ssh/sshd_config
    echoLog "Added User ubuntu to SSH authorised users list"
    service ssh restart
    echoLog "Adding ssh-agent startup to .bashrc for root and ubuntu"
    { echo ""; echo "# ssh-agent"; } >> ~/.bashrc
    { echo ""; echo "# ssh-agent"; } >> /home/ubuntu/.bashrc
    { echo "eval \$(ssh-agent)"; echo "ssh-add ~/.ssh/$keyname"; } >> ~/.bashrc
    { echo "eval \$(ssh-agent)"; echo "ssh-add ~/.ssh/$keyname"; } >> /home/ubuntu/.bashrc
fi
echoLog "New user setup complete!"