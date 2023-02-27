#!/bin/sh
# Author(s): big
# CreateDate: 2023.2.27

resign=$1

projectPath=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/BuildPlatform/iOS/NPLRuntime.xcodeproj
archivePath=/Volumes/CODE/iOSArchive/Paracraft.xcarchive
exportOptions=/Volumes/CODE/iOSArchive/ExportOptions.plist
ipaFolderPath=/Volumes/CODE/iOSArchive/
timeName=`date "+%Y-%m-%d-%H-%M-%S"`
ipaName=Paracraft-$timeName.ipa

pushd /Volumes/CODE/NPLRuntimeCI

git pull origin platform --rebase

popd

xcodebuild -project $projectPath -scheme Paracraft -archivePath $archivePath archive
xcodebuild -exportArchive -archivePath $archivePath -exportPath $ipaFolderPath -exportOptionsPlist $exportOptions

if [ "$1" == "true" ]; then
    # sudo gem install fastlane
    fastlane sigh resign $ipaFolderPath"Paracraft.ipa" \
    --signing_identity "iPhone Distribution: Shenzhen Tatfook Network Co., Ltd. (3FHAD7P7A5)" \
    -p "$ipaFolderPath/2022022301.mobileprovision"
fi

mv $ipaFolderPath"Paracraft.ipa" "$ipaFolderPath""$ipaName"

rm $ipaFolderPath"Packaging.log"
rm $ipaFolderPath"DistributionSummary.plist"
rm -r $ipaFolderPath"Paracraft.xcarchive"
# mv $ipaFolderPath"Paracraft.xcarchive" $ipaFolderPath"Paracraft-"$timeName".xcarchive" 

echo "build name: "$ipaName
