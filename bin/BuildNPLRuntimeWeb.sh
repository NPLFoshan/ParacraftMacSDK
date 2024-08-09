#!/bin/bash

pushd /Volumes/CODE/webparacraft

rm -r paracraft_asset.data
rm -r paracraft_asset.js
rm -r ParaCraftSingleThread.js
rm -r ParaCraftSingleThread.wasm

popd

pushd /Volumes/CODE/NPLRuntime/NPLRuntime/Platform/SDL/emscripten
touch main.cpp
popd

pushd /Volumes/CODE/NPLRuntime/NPLRuntime/BuildPlatform/web
ninja
popd

