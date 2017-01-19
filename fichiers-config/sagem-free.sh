#! /bin/sh
# /etc/init.d/sagem-free.sh
# Script qui établit la connexion ADSL à Free via le modem SAGEM USB
# Formation Debian GNU/Linux par Alexis de Lattre
# http://formation-debian.via.ecp.fr/

echo -n "Starting the connexion to Free via the SAGEM modem:"
/usr/sbin/startadsl 1> /dev/null 2>&1
echo " done."
