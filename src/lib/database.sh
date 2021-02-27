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

if [[ -f "$SQL" ]]; then rm -f "$SQL"; fi
{ echo "CREATE USER 'root'@'localhost' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}';"; echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"; } >> "$SQL"

if [[ ${#IPS[@]} -gt 1 ]]; then
    for key in "${!IPS[@]}"
    do
        if [ -n "${IPS[$key]}" ]; then
            { echo "CREATE USER 'root'@'${IPS[$key]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}';"; echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'${IPS[$key]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"; } >> "$SQL"
            { echo "CREATE USER 'root'@'${FQDNS[$key]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}';"; echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'${FQDNS[$key]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"; } >> "$SQL"
        fi
    done
else
    { echo "CREATE USER 'root'@'${REGISTRY[IPv4_PUBLIC]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}';"; echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'${REGISTRY[IPv4_PUBLIC]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"; } >> "$SQL"
    { echo "CREATE USER 'root'@'${REGISTRY[FQDN]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}';"; echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'${REGISTRY[FQDN]}' IDENTIFIED BY '${PASSWORDS[MYSQL_ROOT]}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"; } >> "$SQL"
fi

echoLog "spacer"
echoLog "DONE!"
echoLog "spacer"
echoLog "Writing to Database"
echoLog "spacer"

echoLog "Database Import " -n
if ! mysql -u root -p"${PASSWORDS[MYSQL_ROOT]}" < "$SQL"; then echoLog "FAILED!" -c; else echoLog "SUCCEEDED!" -c; fi

echoLog "spacer"
echoLog "DONE!"
