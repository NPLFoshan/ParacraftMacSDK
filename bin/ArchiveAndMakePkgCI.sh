#!/bin/sh
# Author(s): big
# CreateDate: 2023.2.10

dev=$1

projectPath=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/BuildPlatform/mac/NPLRuntime.xcodeproj
archivePath=/Volumes/CODE/MacArchive/Paracraft.xcarchive
exportOptions=/Volumes/CODE/MacArchive/ExportOptions.plist
pkgFolderPath=/Volumes/CODE/MacArchive/
dest_path=/Volumes/CODE/NPLRuntimeCI/NPLRuntime/Platform/OSX/assets 
timeName=`date "+%Y-%m-%d-%H-%M-%S"`

ver=`cat $dest_path/version.txt | sed 's/ver=//g'`
verStr=$ver"-"

if [ "$dev" == "true" ]; then
    devStr="dev-"
fi

pkgName=Paracraft-$devStr$verStr$timeName.pkg

pushd /Volumes/CODE/NPLRuntimeCI
git stash
git pull lixizhi cp_old --rebase
got stash pop
popd

xcodebuild -project $projectPath -scheme Paracraft -archivePath $archivePath archive
xcodebuild -exportArchive -archivePath $archivePath -exportPath $pkgFolderPath -exportOptionsPlist $exportOptions

mv $pkgFolderPath"Paracraft.pkg" "$pkgFolderPath""$pkgName"

rm $pkgFolderPath"Packaging.log"
rm $pkgFolderPath"DistributionSummary.plist"
rm -r $pkgFolderPath"Paracraft.xcarchive"
# mv $pkgFolderPath"Paracraft.xcarchive" $pkgFolderPath"Paracraft-"$timeName".xcarchive" 

echo "build name: "$pkgName
