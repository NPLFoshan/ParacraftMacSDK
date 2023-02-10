#/bin/sh

ciFolder=
ipaFolderPath=
macFolderPath=
password=

while true
do
  if [ -f $ciFolder"new_ipa.txt" ]; then
    ipaName=`cat $ciFolder"new_ipa.txt"`

    sshpass -p $password scp -P 10022 $ipaFolderPath$ipaName big@10.8.0.2:~/
    sshpass -p $password ssh big@10.8.0.2 -p 10022 "cd ~;./UpToFtp.sh $ipaName"

    rm $ciFolder"new_ipa.txt"
    echo 'IPA上传：'$ipaName | terminal-notifier -sound default
  fi

  if [ -f $ciFolder"new_pkg.txt" ]; then
    pkgName=`cat $ciFolder"new_pkg.txt"`

    sshpass -p $password scp -P 10022 $macFolderPath$pkgName big@10.8.0.2:~/
    sshpass -p $password ssh big@10.8.0.2 -p 10022 "cd ~;./PkgUpToFtp.sh $pkgName"

    rm $ciFolder"new_pkg.txt"
    echo 'PKG上传：'$pkgName | terminal-notifier -sound default
  fi

  sleep 3;
done
