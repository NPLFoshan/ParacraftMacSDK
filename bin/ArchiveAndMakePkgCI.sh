#!/bin/sh
# Author(s): big
# CreateDate: 2023.2.10

echo make pkg......

dev=$1
http_env=$2
is_papa_adventure=$3

echo dev:$dev
echo http_env:$http_env
echo is_papa_adventure:$is_papa_adventure

if [ "$is_papa_adventure" == "true" ]; then
projectPath=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/BuildPlatform/mac-papaadventure/NPLRuntime.xcodeproj
else
projectPath=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/BuildPlatform/mac/NPLRuntime.xcodeproj
fi

archivePath=/Volumes/CODE/MacArchive/Paracraft.xcarchive
exportOptions=/Volumes/CODE/MacArchive/ExportOptions.plist
pkgFolderPath=/Volumes/CODE/MacArchive/
dest_path=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/Platform/OSX/assets 
timeName=`date "+%Y-%m-%d-%H-%M-%S"`

echo project path:$projectPath
echo archive path:$archivePath
echo export options:$exportOptions
echo pkg folder path:$pkgFolderPath
echo time name:$timeName

ver=`cat $dest_path/version.txt | sed 's/ver=//g'`
verStr=$ver"-"

if [ "$dev" == "true" ]; then
    devStr="dev-"
fi

httpEnvStr=""

if [ "$http_env" == "RELEASE" ]; then
    httpEnvStr="apirls-"
elif [ "$http_env" == "STAGE" ]; then
    httpEnvStr="apidev-"
fi

if [ "$is_papa_adventure" == "true" ]; then
    pkgName=papa-adventure-$devStr$verStr$httpEnvStr$timeName.pkg
else
    pkgName=Paracraft-$devStr$verStr$httpEnvStr$timeName.pkg
fi

pushd /Volumes/CODE/NPLRuntimeCI
git stash
git pull lixizhi cp_old --rebase
got stash pop
popd

xcodebuild -project $projectPath -scheme Paracraft -archivePath $archivePath archive
xcodebuild -exportArchive -archivePath $archivePath -exportPath $pkgFolderPath -exportOptionsPlist $exportOptions

if [ "$is_papa_adventure" == "true" ]; then
    mv $pkgFolderPath"帕帕奇遇记.pkg" "$pkgFolderPath""$pkgName"
else
    mv $pkgFolderPath"Paracraft.pkg" "$pkgFolderPath""$pkgName"
fi

rm $pkgFolderPath"Packaging.log"
rm $pkgFolderPath"DistributionSummary.plist"
rm -r $pkgFolderPath"Paracraft.xcarchive"
# mv $pkgFolderPath"Paracraft.xcarchive" $pkgFolderPath"Paracraft-"$timeName".xcarchive" 

echo "build name: "$pkgName
