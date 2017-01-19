#! /bin/sh
# /etc/init.d/eciadsl.sh
# Script qui établit la connexion du modem ECI ADSL
# Formation Debian GNU/Linux par Alexis de Lattre
# http://formation-debian.via.ecp.fr/

echo -n "Starting the ECI ADSL modem:"

# Il faut lancer la commande "startmodem" deux fois...
# car il paraît que ça ne marche pas souvent du premier coup !

/usr/bin/startmodem 1> /dev/null 2>&1
/usr/bin/startmodem 1> /dev/null 2>&1

echo " done."
