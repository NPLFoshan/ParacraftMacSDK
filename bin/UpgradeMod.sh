#!/bin/bash

machine_username=$(whoami)
resource_path=/Users/$machine_username/Library/Containers/com.tatfook.paracraftmac/Data/Documents/Paracraft/files
mod_root=$resource_path/dev

update_mod()
{
    mod_name="$1"

    echo $mod_name
    pushd $mod_root/$mod_name
    git pull --rebase
    popd
}

update_mod WorldShare
update_mod ExplorerApp
