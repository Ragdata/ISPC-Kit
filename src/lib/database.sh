#-------------------------------------------------------------------
# src/lib/database.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         database.sh
# Author:       Ragdata
# Date:         27/02/2021 1826
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
clear
echoLog "Creating Database Entries"
echoLog "line"
echoLog "spacer"
if [[ ${#IPS[@]} -gt 1 ]]; then
    for key in "${!IPS[@]}"
    do
        echo "CREATE USER 'root'@'${IPS[$key]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}';" >> "$sqlDir"/database.sql
        echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'${IPS[$key]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
        echo "CREATE USER 'root'@'${FQDNS[$key]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}';" >> "$sqlDir"/database.sql
        echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'${FQDNS[$key]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
    done
else

    echo "CREATE USER 'root'@'${REGISTRY[IPv4_PUBLIC]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}';" >> "$sqlDir"/database.sql
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'${REGISTRY[IPv4_PUBLIC]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
    echo "CREATE USER 'root'@'${REGISTRY[FQDN]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}';" >> "$sqlDir"/database.sql
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'${REGISTRY[FQDN]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
fi
echoLog "spacer"
echoLog "DONE!"
echoLog "spacer"
echoLog "Writing to Database"
echoLog "spacer"

mysql -u root -p"${PASSWORDS[MYSQL_ROOT]}" < "$sqlDir"/database.sql

echoLog "DONE!"
