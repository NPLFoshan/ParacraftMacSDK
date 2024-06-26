#!/bin/bash

machine_username=$(whoami)

files_path=/Users/$machine_username/Library/Containers/com.tatfook.paracraftmac/Data/Documents/Paracraft/files
dev_path=$files_path/dev
application_path=/Applications/Paracraft.app
dest_path=~/APP_DATA/ # change to your project folder
paracraft_build_in_mod_path=/Volumes/CODE/ParacraftBuildinMod

pushd $dev_path/trunk
zip -r $dev_path/main.zip ./ -x "./.git/*"
popd

pushd $files_path

if [ -f "./config.txt" ]; then
	mv ./config.txt ./config.txt.1
fi

if [ -f "$dest_path/main.pkg" ]; then
	rm $dest_path/main.pkg
fi

cat >./create_pkg.lua <<EOL
NPL.load("(gl)script/ide/commonlib.lua"); 

local filesPath = "${files_path}"
local destPath = "${dest_path}"
local originFile = "${dev_path}/main.zip"
local encryptFile = "${dev_path}/main.pkg"

ParaAsset.GeneratePkgFile(originFile, encryptFile)
-- ParaIO.CopyFile(encryptFile, destPath .. "/main.pkg", true)

ParaIO.DeleteFile(originFile)
--ParaIO.DeleteFile(encryptFile)
ParaIO.DeleteFile(filesPath .. "/create_pkg.lua")
ParaIO.DeleteFile(filesPath .. "/config.txt")

ParaGlobal.ExitApp()
EOL

cat >./config.txt <<EOL
cmdline=noupdate="true" bootstrapper="create_pkg.lua" 
EOL

open -a $application_path

popd

sleep 5

if [ -f "$files_path/config.txt.1" ]; then
	mv $files_path/config.txt.1 $files_path/config.txt
fi

cp $dev_path/main.pkg $dest_path/
rm $dev_path/main.pkg
rm -r $dest_path/npl_packages/ParacraftBuildinMod.zip

# rm -r $paracraft_build_in_mod_path/npl_packages/WorldShare/Mod
# rm -r $paracraft_build_in_mod_path/npl_packages/ExplorerApp/Mod

# cp -r $dev_path/WorldShare/Mod $paracraft_build_in_mod_path/npl_packages/WorldShare
# cp -r $dev_path/ExplorerApp/Mod $paracraft_build_in_mod_path/npl_packages/ExplorerApp

pushd $paracraft_build_in_mod_path
bash ./build_without_update.sh
popd

cp $paracraft_build_in_mod_path/ParacraftBuildinMod.zip $dest_path/npl_packages/

pushd /Volumes/CODE/webparacraft

$EMSDK/upstream/emscripten/tools/file_packager \
"paracraft_asset.data" \
--preload "/Users/$machine_username/APP_DATA@/" \
--js-output="paracraft_asset.js"
