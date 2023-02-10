#!/bin/sh
# Author(s): big
# CreateDate: 2023.2.10

projectPath=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/BuildPlatform/mac/NPLRuntime.xcodeproj
archivePath=/Volumes/CODE/MacArchive/Paracraft.xcarchive
exportOptions=/Volumes/CODE/MacArchive/ExportOptions.plist
pkgFolderPath=/Volumes/CODE/MacArchive/
timeName=`date "+%Y-%m-%d-%H-%M-%S"`
pkgName=Paracraft-$timeName.pkg

xcodebuild -project $projectPath -scheme Paracraft -archivePath $archivePath archive
xcodebuild -exportArchive -archivePath $archivePath -exportPath $pkgFolderPath -exportOptionsPlist $exportOptions

mv $pkgFolderPath"Paracraft.pkg" "$pkgFolderPath""$pkgName"

rm "$pkgFolderPath""$pkgName"
rm $pkgFolderPath"Packaging.log"
rm $pkgFolderPath"DistributionSummary.plist"
rm $pkgFolderPath"Paracraft.xcarchive"
# mv $pkgFolderPath"Paracraft.xcarchive" $pkgFolderPath"Paracraft-"$timeName".xcarchive" 

echo "build name: "$pkgName
