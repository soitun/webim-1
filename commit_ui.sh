#!/bin/sh

cd uchome
git add static
git commit static -m "Update UI"

cd ../discuz
git add static
git commit static -m "Update UI"

cd ../discuzX
git add static
git commit static -m "Update UI"

cd ../phpwind
git add static
git commit static -m "Update UI"
