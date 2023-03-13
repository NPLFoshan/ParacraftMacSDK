#!/bin/sh
# Author(s): big
# CreateDate: 2023.2.27

resign=$1
dev=$2
http_env=$3

projectPath=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/BuildPlatform/iOS/NPLRuntime.xcodeproj
archivePath=/Volumes/CODE/iOSArchive/Paracraft.xcarchive
exportOptions=/Volumes/CODE/iOSArchive/ExportOptions.plist
ipaFolderPath=/Volumes/CODE/iOSArchive/
dest_path=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/Platform/iOS/assets 
timeName=`date "+%Y-%m-%d-%H-%M-%S"`

ver=`cat $dest_path/version.txt | sed 's/ver=//g'`
verStr=$ver"-"

resigned=""

if [ "$resign" == "true" ]; then
    resigned="resigned-"
fi

devStr=""

if [ "$dev" == "true" ]; then
    devStr="dev-"
fi

httpEnvStr=""

if [ "$http_env" == "RELEASE" ]; then
    httpEnvStr="apirls-"
elif [ "$http_env" == "STAGE" ]; then
    httpEnvStr="apidev-"
fi

ipaName=Paracraft-$resigned$devStr$httpEnvStr$verStr$timeName.ipa

pushd /Volumes/CODE/NPLRuntimeCI
git stash
git pull lixizhi cp_old --rebase
git stash pop
popd

xcodebuild -project $projectPath -scheme Paracraft -archivePath $archivePath archive
xcodebuild -exportArchive -archivePath $archivePath -exportPath $ipaFolderPath -exportOptionsPlist $exportOptions

mv $ipaFolderPath"Paracraft.ipa" "$ipaFolderPath""$ipaName"

rm $ipaFolderPath"Packaging.log"
rm $ipaFolderPath"DistributionSummary.plist"
rm -r $ipaFolderPath"Paracraft.xcarchive"
# mv $ipaFolderPath"Paracraft.xcarchive" $ipaFolderPath"Paracraft-"$timeName".xcarchive" 

echo "build name: "$ipaName
