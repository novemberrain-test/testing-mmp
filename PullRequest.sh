#!/bin/bash
set -x
user_name=$1
password=$2
# config user
git config --global user.name "jenkins"
git config --global user.email "jenkins@humana.com"
#clone form kubertest
git clone https://${user_name}:${password}@github.com/novemberrain-test/test-ray.git
# git remote add upstream git@github.com:duydoxuan/test-ray.git
git remote -v 
# fetch latest code from upstream
git fetch https://${user_name}:${password}@github.com/duydoxuan/test-ray.git master
git merge origin/master
#
cd novemberrain-test && mv ver.json ver.json.bak
mv version.json novemberrain-test/ver.json
# push code
git add ver.json
git commit -am "test"
# git push "https://${user_name}:${password}@github.com/novemberrain-test/test-ray.git" jenkins
git push origin