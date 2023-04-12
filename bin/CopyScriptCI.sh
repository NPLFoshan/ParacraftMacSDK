#!/bin/bash

platform=$1
ver=$2
dev=$3
http_env=$4
is_papa_adventure=$5
runtime_path=/Volumes/CODE # change to your project folder

echo platform:$platform;
echo ver:$ver;
echo dev:$dev;
echo http_env:$http_env;
echo is_papa_adventure:$is_papa_adventure;

if [ "$platform" == "mac" ]; then
    dest_path=$runtime_path/NPLRuntimeCI/NPLRuntime/Platform/OSX/assets 
else
    dest_path=$runtime_path/NPLRuntimeCI/NPLRuntime/Platform/iOS/assets 
fi

rm -r $dest_path/npl_packages/ParacraftBuildinMod.zip
rm -r $dest_path/main.pkg
rm -r $dest_path/main150727.pkg
rm -r $dest_path/assets_manifest.txt
rm -r $dest_path/version.txt
rm -r $dest_path/config.txt

curl -o $dest_path/main.pkg http://10.8.0.2/main.pkg
curl -o $dest_path/assets_manifest.txt http://10.8.0.2/assets_manifest.txt._P_E_0

if [ "$dev" == "true" ]; then
    echo download dev
    curl -o $dest_path/main150727.pkg http://10.8.0.2/main_dev.pkg
    curl -o $dest_path/npl_packages/ParacraftBuildinMod.zip http://10.8.0.2/ParacraftBuildinMod_dev.zip
else
    echo download master
    curl -o $dest_path/main150727.pkg http://10.8.0.2/main150727.pkg
    curl -o $dest_path/npl_packages/ParacraftBuildinMod.zip http://10.8.0.2/ParacraftBuildinMod.zip
fi

if [ -z $ver ]; then
    result=`curl http://10.8.0.2/coredownload/version.txt |
        sed -n "/<UpdateVersion>/,/<\/UpdateVersion>/p" |
        sed "s/<UpdateVersion>//i" |
        sed "s/<\/UpdateVersion>//i" |
        sed "s/\r\n//i"`
    result="ver="$result

    echo $result | sed 's/ //g' >> $dest_path/version.txt
else
    echo "ver="$ver >> $dest_path/version.txt
fi

config='cmdline=noupdate="true" debug="main" mc="true" bootstrapper="script/apps/Aries/main_loop.lua"'

if [ "$http_env" == "RELEASE" ]; then
    config=$config' http_env="RELEASE"'
elif [ "$http_env" == "STAGE" ]; then
    config=$config' http_env="STAGE"'
fi

if [ "$is_papa_adventure" == "true" ]; then
    config=$config' http_env="STAGE" channelId="tutorial" isDevMode="true"'
fi

echo $config;

echo $config >> $dest_path/config.txt
