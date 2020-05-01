#!/bin/bash
declare -a worlds=(castle castle_nether castle_the_end)
backupdir=/root/minecraft/backups
minecraft_directory=/root/minecraft
ext=.zip

GREEN='\033[0;32m'
LIGHT_BLUE='\033[1;34m'
NC='\033[0m'

hdateformat=$(date '+%Y-%m-%d-%Hh-%Mm-%Ss')$ext
ddateformat=$(date '+%Y-%m-%d')$ext
numworlds=${#worlds[@]}
    if [ ! -d $backupdir ] ; then
        mkdir -p $backupdir
    fi

    for ((i=0;i<$numworlds;i++)); do
        if [ ! -d $backupdir/hourly/${worlds[$i]} ]; then
            mkdir $backupdir/hourly/${worlds[$i]}
        fi
        if [ ! -d $backupdir/daily/${worlds[$i]} ]; then
            mkdir $backupdir/daily/${worlds[$i]}
        fi
            # echo -e "${GREEN}[ START ] ${NC}Backing up the folder for '${worlds[$i]}' to '$backupdir/hourly/${worlds[$i]}/$hdateformat'."
        zip -q $backupdir/hourly/${worlds[$i]}/$hdateformat -r $minecraft_directory/${worlds[$i]}
            # echo -e "${LIGHT_BLUE}[ COMPLETED ] ${NC}Backed up the folder for '${worlds[$i]}'." 
        if [ $(find $backupdir/daily/${worlds[$i]}/ -type f -mmin -1440 | wc -l) = 0 ]; then
            cp $backupdir/hourly/${worlds[$i]}/$hdateformat $backupdir/daily/${worlds[$i]}/
            # echo -e "Created the daily backup for the folder '${worlds[$i]}'\n"
        # else
            # echo -e "Did not create the daily backup for the folder '${worlds[$i]}'\n"
        fi
    done

    # echo -e "${GREEN}[ START ] ${NC}Backing up the folder for 'plugins' to '$backupdir/hourly/plugins/$hdateformat'."
    zip -q $backupdir/hourly/plugins/$hdateformat -r $minecraft_directory/plugins
    # echo -e "${LIGHT_BLUE}[ COMPLETED ] ${NC}Backed up the folder for 'plugins'."
    if [ $(find $backupdir/daily/plugins/ -type f -mmin -1440 | wc -l) = 0 ]; then
        cp $backupdir/hourly/plugins/$hdateformat $backupdir/daily/plugins/
        # echo -e "Created the daily backup for the folder 'plugins'\n"
    # else
        # echo -e "Did not create the daily backup for the folder 'plugins'\n"
    fi

    # echo -e "${LIGHT_BLUE} [ BACKUP ] ${NC}Backup of the worlds complete."
    find $backupdir/hourly -type f -mmin +1440 -exec rm {} \;
    find $backupdir/daily -type f -mtime +14 -exec rm {} \;
    find $minecraft_directory/logs -type f -mtime +14 -exec rm {} \;
    # echo -e "${LIGHT_BLUE} [ BACKUP ] ${NC}Removed old backups." 
exit 0
