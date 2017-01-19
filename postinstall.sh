#!/bin/bash

# Mon script de post installation serveur Debian 8 aka Jessie
#
# ALLAN Maxime - 01/2017
# GPL
#
# Syntaxe: # su - -c "./postinstall.sh"
# Syntaxe: or # sudo ./postinstall.sh
VERSION="0.1"

#=============================================================================
# Liste des applications ànstaller: A adapter a vos besoins
LISTE="vim zsh curl iftop htop tcpdump"
#=============================================================================

# Test que le script est lance en root
if [ $EUID -ne 0 ]; then
  echo -e "\nLe script doit êe lance en root: # sudo $0" 1>&2
  exit 1
fi


# Mise a jour de la liste des depots
#-----------------------------------

# Update
echo -e "\n### Mise a jour de la liste des depots\n"
apt update

# Upgrade
echo -e "\n### Mise a jour du systeme\n"
apt -y upgrade

# Installation
echo -e "\n### Installation des logiciels suivants: $LISTE\n"
apt -y install $LISTE

# Configuration
#--------------

echo -e "\n### Installation des fichiers de configuration \n"
cd /tmp/post-install/fichiers-config

echo -e "\n### Configuration de ZSH et VIM \n"
# ZSH
cd /tmp/post-install/fichiers-config/
mv zshrc zshenv zlogin zlogout /etc/zsh/
mv dir_colors /etc/
curl https://raw.githubusercontent.com/GeoHolz/Extract/master/extract.sh >> /etc/zsh/zshrc
sed -i 's/bash/zsh/g' /etc/passwd

# VIM
cd /tmp/post-install/
cp fichiers-config/vimrc /etc/vim/ -f


echo -e "\n### Configuration finit. Il faut vous deconnecter/reconnecter pour que les modifications prennents effets"
echo "### Lors de la premié connexion, il est prérable de choisir l'option 2 pour ZSH."
# Fin du script
