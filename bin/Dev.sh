#!/bin/bash
# Author(s): big
# CreateDate: 2021.9.29
# ModifyDate: 2021.10.12

machine_username=$(whoami)
resource_path=/Users/$machine_username/Library/Containers/com.tatfook.paracraftmac/Data/Documents/Paracraft/files
application_path=/Applications/Paracraft.app
config_file=""
config_content=""
env="ONLINE"

if [ "$1" == "-h" ]; then
    if [ "$2" == "-http_env" ]; then
        if [ "$3" == "RELEASE" ]; then
            config_file="DevRlsWithHttpDebugConfig.txt"
        else
            config_file="DevWithHttpDebugConfig.txt"  
        fi
    else
        config_file="DevWithHttpDebugConfig.txt"
    fi
else
    config_file="DevConfig.txt"
fi

if [ "$2" == "STAGE" ]; then
    env="STAGE"
fi

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

config_content=`cat $(dirname $0)/../config/$config_file`
config_content=`sed "s/{{username}}/"$machine_username"/" <<< "$config_content"`
config_content=$config_content" http_env=\""$env"\""

rm -f "$resource_path/config.txt"

echo $config_content >> $resource_path/config.txt

if [ "$1" == "-a" ]; then
    code $resource_path/dev
    code $resource_path/log.txt
fi

pkill Paracraft
sleep 0.5
pkill Paracraft
sleep 0.5
open -a $application_path