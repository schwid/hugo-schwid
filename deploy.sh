#!/bin/bash

hugo
cp -R public/* ../schwid.github.io/

pushd ../schwid.github.io

git add *
git commit -m "deploy"
git push

popd
