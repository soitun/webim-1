#!/bin/sh

cd uchome
git commit static -m "Update UI"

cd ../discuz
git commit static -m "Update UI"

cd ../discuzX
git commit static -m "Update UI"
