#!/bin/sh
# Author(s): big
# CreateDate: 2023.1.13

projectPath=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/BuildPlatform/iOS/NPLRuntime.xcodeproj
archivePath=/Volumes/CODE/iOSArchive/Paracraft.xcarchive
exportOptions=/Volumes/CODE/iOSArchive/ExportOptions.plist
ipaFolderPath=/Volumes/CODE/iOSArchive/
timeName=`date "+%Y-%m-%d-%H-%M-%S"`
ipaName=Paracraft-$timeName.ipa
password=

xcodebuild -project $projectPath -scheme Paracraft -archivePath $archivePath archive
xcodebuild -exportArchive -archivePath $archivePath -exportPath $ipaFolderPath -exportOptionsPlist $exportOptions

mv $ipaFolderPath"Paracraft.ipa" "$ipaFolderPath""$ipaName"

# pushd $ipaFolderPath

# sshpass -p $password scp -P 10022 ./$ipaName big@10.8.0.2:~/
# sshpass -p $password ssh big@10.8.0.2 -p 10022 "cd ~;./UpToFtp.sh $ipaName"

# popd

# rm "$ipaFolderPath""$ipaName"
rm $ipaFolderPath"Packaging.log"
rm $ipaFolderPath"DistributionSummary.plist"

mv $ipaFolderPath"Paracraft.xcarchive" $ipaFolderPath"Paracraft-"$timeName".xcarchive" 

echo "build name: "$ipaName
