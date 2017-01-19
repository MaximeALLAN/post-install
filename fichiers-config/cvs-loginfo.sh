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


# parameters
mailfrom="$1";
mailto="$2";
subject="$3";
user="$4";

# external programs
AWK=/usr/bin/awk
CAT=/bin/cat
CSPLIT=/usr/bin/csplit
CUT=/usr/bin/cut
FIND=/usr/bin/find
GREP=/bin/grep
MAIL=/usr/bin/mail
RM=/bin/rm
WC=/usr/bin/wc

# temporary files
directories="/tmp/cvslog.$PPID.directories"
log="/tmp/cvslog.$PPID"
pattern="/tmp/cvslog.$PPID.$$."
head="/tmp/cvslog.$PPID.$$.00"
message="/tmp/cvslog.$PPID.$$.01"


# split the loginfo message
$CSPLIT -qf "$pattern" - "/Log Message:/"
$GREP -hv '^In directory' "$head" | $GREP -hv '^$' >> "$log"
echo >> "$log"

# is it the last directory ?
NB_MAIL=`$GREP '^$' "$log" 2> /dev/null | $WC -l`
if ( test -f "$directories" )
then
        NB_COMMIT=`$CAT "$directories" | $WC -l`
else
        NB_COMMIT=1
fi
if [[ $NB_MAIL -ge $NB_COMMIT ]]
then
	# complete and send the mail
	$AWK  'BEGIN { n=0 ; } { if ( $0 ~ "^[ \t\f\n\r\v]*$" ) { n++; } else { for ( i=0; i<n; i++ ) printf "\n"; print $0; n=0; } }' "$message" >> "$log"
	echo -e "\n-- \n$user" >> "$log"
	$CAT "$log" | $MAIL -s "$subject ($user)" -a "From: $mailfrom" "$mailto"
	# clean up
	$RM -f $log
	$RM -f $directories
fi

# clean up
$RM -f "$pattern"*
