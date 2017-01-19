#! /bin/sh

# /usr/local/bin/cvs-commitinfo.sh et /usr/local/bin/cvs-loginfo.sh
# Scripts de notification par mail des commits du CVS
# Version 1.2
# Scripts écrits par Boris Dorès <babal@via.ecp.fr> - 2003
# Formation Debian GNU/Linux par Alexis de Lattre
# http://formation-debian.via.ecp.fr/


# Pour mettre en place la notification par mail :
# 1) copiez les fichiers cvs-loginfo.sh et cvs-commitinfo.sh dans le répertoire
#    /usr/local/bin/
#
# 2) ajoutez dans le fichier
#    /var/lib/cvs/nom_du_projet/CVSROOT/commitinfo la ligne suivante :

#ALL /usr/local/bin/cvs-commitinfo.sh

# 3) ajoutez dans le fichier
#    /var/lib/cvs/nom_du_projet/CVSROOT/loginfo la ligne suivante :

#ALL /usr/local/bin/cvs-loginfo.sh adresse_de_provenance adresse_destination "Sujet_des_mails" $USER

echo "$1" >> /tmp/cvslog.$PPID.directories
