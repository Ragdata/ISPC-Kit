#-------------------------------------------------------------------
# src/etc/perl.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         perl.sh
# Author:       Ragdata
# Date:         27/02/2021 0116
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Perl 5 + Extensions ..."
echoLog "line"

apt_install perl perl-openssl-defaults perl-doc libterm-readline-gnu-perl libdbi-perl libdbd-mysql-perl
apt_install libsql-statement-perl libclone-perl libmldbm-perl libnet-daemon-perl

echoLog "spacer"
echoLog "${yellow}Perl 5 + Extensions${NC} Successfully Installed!"
