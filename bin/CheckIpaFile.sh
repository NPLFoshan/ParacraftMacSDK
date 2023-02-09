#/bin/sh

ciFolder=/Volumes/CODE/CI/
ipaFolderPath=/Volumes/CODE/iOSArchive/
password=

while true
do
  if [ -f $ciFolder"new_ipa.txt" ]; then
    ipaName=`cat $ciFolder"new_ipa.txt"`

    sshpass -p $password scp -P 10022 $ipaFolderPath$ipaName big@10.8.0.2:~/
    sshpass -p $password ssh big@10.8.0.2 -p 10022 "cd ~;./UpToFtp.sh $ipaName"

    rm $ciFolder"new_ipa.txt"
  fi

  sleep 3;
done
