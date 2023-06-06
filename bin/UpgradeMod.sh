#!/bin/bash
# Author(s): big
# CreateDate: 2021.9.29

machine_username=$(whoami)
resource_path=/Users/$machine_username/Library/Containers/com.tatfook.paracraftmac/Data/Documents/Paracraft/files
mod_root=$resource_path/dev

echo "Upgrade mod starting..."

update_mod()
{
    mod_name="$1"

    echo $mod_name

    if [ ! -d "$mod_root/$mod_name" ]; then
        # if [ "$mod_name" == "WorldShare" ]; then
        #     git clone ssh://git@code.kp-para.cn:10022/paracraft/worldshare.git $mod_root/$mod_name
        #     git checkout dev
        # fi

        # if [ "$mod_name" == "ExplorerApp" ]; then
        #     git clone git@github.com:tatfook/ExplorerApp.git $mod_root/$mod_name
        # fi

        if [ "$mod_name" == "DiffWorld" ]; then
            git clone git@github.com:tatfook/DiffWorld.git $mod_root/$mod_name
        fi

        if [ "$mod_name" == "trunk" ]; then
            git clone ssh://git@code.kp-para.cn:10022/paracraft/paracraft_script.git $mod_root/$mod_name
        fi
    fi

    pushd $mod_root/$mod_name

    git pull --rebase
    
    popd
}

update_mod WorldShare
update_mod ExplorerApp
update_mod DiffWorld
update_mod trunk
