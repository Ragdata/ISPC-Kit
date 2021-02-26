#-------------------------------------------------------------------
# src/etc/fail2ban.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         fail2ban.sh
# Author:       Ragdata
# Date:         23/02/2021 1447
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing Anti-Intrusion Protection (Fail2Ban) ..."
echoLog "spacer"

apt_install fail2ban

echoLog "spacer"
echoLog "${yellow}Fail2Ban${NC} Successfully Installed!"
echoLog "spacer"

echoLog "Configuring Fail2Ban"
echoLog "spacer"

cat > /etc/fail2ban/jail.local <<EOF
[dovecot]
enabled = true
filter = dovecot
logpath = /var/log/mail.log
maxretry = 5

[pureftpd]
enabled = true
port = ftp
filter = pure-ftpd
logpath = /var/log/syslog
maxretry = 3

[postfix-sasl]
enabled = true
port = smtp
filter = postfix-sasl
logpath = /var/log/mail.log
maxretry = 5

EOF

echoLog
echoLog "${yellow}Fail2Ban${NC} Successfully Configured!"
