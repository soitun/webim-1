#!/bin/sh

cd uchome
git pull
git push

cd ../discuz
git pull
git push

cd ../discuzX
git pull
git push

cd ../phpwind
git pull
git push
