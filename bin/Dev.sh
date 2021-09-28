#!/bin/bash

machine_username=$(whoami)
resource_path=/Users/$machine_username/Library/Containers/com.tatfook.paracraftmac/Data/Documents/Paracraft/files
application_path=/Applications/Paracraft.app
config_content=""

if [ ! -d "$application_path" ]; then
    echo "Paracraft is not installed"
    exit
fi

if [ ! -f "$resource_path/config_type" ]; then
    rm -f "$resource_path/config.txt"

    echo "DEV" >> "$resource_path/config_type"
else
    config_type=`cat $resource_path/config_type`

    if [ "$config_type" != "DEV" ]; then
        rm -f "$resource_path/config_type"
        rm -f "$resource_path/config.txt"

        echo "DEV" >> "$resource_path/config_type"
    fi
fi

if [ ! -f "$resource_path/config.txt" ]; then
    config_content=`cat $(dirname $0)/../config/DevConfig.txt`
    config_content=`sed "s/{{username}}/"$machine_username"/" <<< $config_content`

    echo $config_content >> $resource_path/config.txt
fi

open -a $application_path