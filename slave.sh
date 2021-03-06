#!/bin/sh
##################################
# RSYNC from SYNC Folder script  #
# 2016 Giovanni Metitieri        #
##################################
#Setup settings
###
USER="giovanni" #User, useful to find path
SYNC="CLOUD" #The Sync Folder name
CRYFS="CryFSFolder" #The CryFS Folder Name
PASSWORD="password" #Password of CryFS File
FOLDER="folder.txt" #File with folder, one per line
#Create Directory if not created
###
mkdir -p /home/$USER/$SYNC/$CRYFS
mkdir -p /home/$USER/$CRYFS
#Mount and create config if first time setup
###
export CRYFS_FRONTEND=noninteractive
echo "$PASSWORD" | cryfs /home/$USER/$SYNC/$CRYFS /home/$USER/$CRYFS
#Do Rsync from CLOUD 
###
while read folder; do
        rsync -rtlPu /home/$USER/$CRYFS/$folder /home/$USER/ 
done < $FOLDER
#Unmount Filesystem
###
#fusermount -u "/home/$USER/$CRYFS"
#Enjoy
###
# You can setup a cronjob every hour easy with "crontab -e"
# @hourly /path/to/slave.sh
###
