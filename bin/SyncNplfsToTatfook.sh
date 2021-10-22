#!/bin/bash
# Author(s): big
# CreateDate: 2021.10.19

# bash ./UpgradeMod.sh

echo "Sync Mod starting..."

machine_username=$(whoami)
resource_path=/Users/$machine_username/Library/Containers/com.tatfook.paracraftmac/Data/Documents/Paracraft/files
mod_root=$resource_path/dev

update_mod()
{
    mod_name="$1"

    echo $mod_name

    pushd $mod_root/$mod_name

    nplfs=`git remote | grep nplfs`

    if [ $nplfs ] && [ "$nplfs" == "nplfs" ]; then
        git pull nplfs master --rebase
    fi
}

sync_mod()
{
    mod_name="$1"

    echo $mod_name

    pushd $mod_root/$mod_name

    origin=`git remote | grep origin`

    if [ $origin ] && [ "$origin" == "origin" ]; then
        git push origin master
    fi
}

update_mod WorldShare
sync_mod WorldShare