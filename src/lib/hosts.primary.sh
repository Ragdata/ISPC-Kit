#-------------------------------------------------------------------
# src/lib/hosts.primary.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         hosts.primary.sh
# Author:       Ragdata
# Date:         27/01/2021 1618
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Updating /etc/cloud/templates/hosts.debian.tmpl template file"
echoLog "spacer"

mv /etc/cloud/templates/hosts.debian.tmpl /etc/cloud/templates/hosts.debian.tmpl.bak

cat > /etc/cloud/templates/hosts.debian.tmpl <<EOF
## template:jinja
{#
This file (/etc/cloud/templates/hosts.debian.tmpl) is only utilized
if enabled in cloud-config.  Specifically, in order to enable it
you need to add the following to config:
   manage_etc_hosts: True
-#}
# Your system has configured 'manage_etc_hosts' as True.
# As a result, if you wish for changes to this file to persist
# then you will need to either
# a.) make changes to the master file in /etc/cloud/templates/hosts.debian.tmpl
# b.) change or remove the value of 'manage_etc_hosts' in
#     /etc/cloud/cloud.cfg or cloud-config from user-data
#
{# The value '{{hostname}}' will be replaced with the local-hostname -#}
127.0.1.1 {{fqdn}} {{hostname}}
127.0.0.1 localhost

178.128.113.129 {{fqdn}} {{hostname}}
10.104.0.3      {{fqdn}} {{hostname}}
128.199.218.64  ns2.aever.net ns2
10.104.0.2      ns2.aever.net ns2

# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts

2400:6180:0:d1::610:8001    {{fqdn}} {{hostname}}
fe80::8cba:46ff:fe7c:a64f   {{fqdn}} {{hostname}}
2400:6180:0:d0::f3:4001     ns2.aever.net ns2
EOF

echo "Updating /etc/hosts file ..."
log "spacer"
log "/etc/hosts file"
log "line"
echo

mv /etc/hosts /etc/hosts.bak

cat > /etc/hosts <<EOF
# Your system has configured 'manage_etc_hosts' as True.
# As a result, if you wish for changes to this file to persist
# then you will need to either
# a.) make changes to the master file in /etc/cloud/templates/hosts.debian.tmpl
# b.) change or remove the value of 'manage_etc_hosts' in
#     /etc/cloud/cloud.cfg or cloud-config from user-data
#
127.0.1.1 ns1.aever.net ns1
127.0.0.1 localhost

128.199.248.203 ns1.aever.net ns1
10.104.0.3      ns1.aever.net ns1
128.199.238.62  ns2.aever.net ns2
10.104.0.2      ns2.aever.net ns2

# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts

2400:6180:0:d0::19b:8001    ns1.aever.net ns1
fe80::8cba:46ff:fe7c:a64f   ns1.aever.net ns1
2400:6180:0:d0::f3:4001     ns2.aever.net ns2
EOF
