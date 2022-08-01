#!/bin/bash

machine_username=$(whoami)

source_path=/Users/$machine_username/Library/Containers/com.tatfook.paracraftmac/Data/Documents/Paracraft/files/dev/trunk/script
dest_path=/Volumes/CODE/NPLRuntime/NPLRuntime/Platform/iOS/assets # change to your project folder

rm -rf /Volumes/CODE/NPLRuntime/NPLRuntime/Platform/iOS/assets/script
cp -r $source_path $dest_path
