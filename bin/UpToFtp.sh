#!/bin/sh
# Author(s): big
# CreateDate: 2023.1.13

filename=$1
username=
password=

curl -u $admin:$password -T ./$filename ftp://10.27.1.94/paracraft/iOS/

rm $filename

echo "UPLOAD FINISHED."
