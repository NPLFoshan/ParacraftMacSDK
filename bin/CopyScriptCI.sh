#!/bin/bash

platform=$1
runtime_path=/Volumes/CODE # change to your project folder

if [ "$1" == "mac" ]; then
    dest_path=$runtime_path/NPLRuntimeCI/NPLRuntime/Platform/OSX/assets 
else
    dest_path=$runtime_path/NPLRuntimeCI/NPLRuntime/Platform/iOS/assets 
fi

rm -r $dest_path/npl_packages/ParacraftBuildinMod.zip
rm -r $dest_path/main.pkg
rm -r $dest_path/main150727.pkg
rm -r $dest_path/assets_manifest.txt
rm -r $dest_path/version.txt

curl -o $dest_path/npl_packages/ParacraftBuildinMod.zip http://10.8.0.2/ParacraftBuildinMod.zip
curl -o $dest_path/main.pkg http://10.8.0.2/main.pkg
curl -o $dest_path/main150727.pkg http://10.8.0.2/main150727.pkg
curl -o $dest_path/assets_manifest.txt http://10.8.0.2/assets_manifest.txt._P_E_0

result=`curl http://10.8.0.2/coredownload/version.txt |
        sed -n "/<UpdateVersion>/,/<\/UpdateVersion>/p" |
        sed "s/<UpdateVersion>//i" |
        sed "s/<\/UpdateVersion>//i" |
        sed "s/\r\n//i"`
echo $result >> $dest_path/version.txt
