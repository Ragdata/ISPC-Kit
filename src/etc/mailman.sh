#-------------------------------------------------------------------
# src/etc/mailman.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         mailman.sh
# Author:       Ragdata
# Date:         23/02/2021 1455
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing Mailman (Mailing List Manager)"
echoLog "spacer"

apt_install mailman

echoLog "spacer"
echoLog "${yellow}Mailman${NC} Successfully Installed!"

echoLog "spacer"
echoLog "Configure Mailman Mailing List Manager ... "
echoLog "spacer"

newlist mailman

cat > /etc/aliases <<EOF
## mailman mailing list
mailman: "|/var/lib/mailman/mail/mailman post mailman"
mailman-admin: "|/var/lib/mailman/mail/mailman admin mailman"
mailman-bounces: "|/var/lib/mailman/mail/mailman bounces mailman"
mailman-confirm: "|/var/lib/mailman/mail/mailman confirm mailman"
mailman-join: "|/var/lib/mailman/mail/mailman join mailman"
mailman-leave: "|/var/lib/mailman/mail/mailman leave mailman"
mailman-owner: "|/var/lib/mailman/mail/mailman owner mailman"
mailman-request: "|/var/lib/mailman/mail/mailman request mailman"
mailman-subscribe: "|/var/lib/mailman/mail/mailman subscribe mailman"
mailman-unsubscribe: "|/var/lib/mailman/mail/mailman unsubscribe mailman"
EOF

newaliases

service postfix restart

if ! service mailman start; then errorExit "MAILMAN ERROR: Failed to start Mailing List Manager"; fi

echoLog
echoLog "${yellow}Mailman${NC} Successfully Configured!"
