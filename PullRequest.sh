#!/bin/bash
user_name=$1
password=$2
# config user
git config --global user.name "jenkins"
git config --global user.email "jenkins@humana.com"
git add ver.json
git commit -am "test"
git push "https://${user_name}:${password}@github.com/novemberrain-test/test-ray.git" jenkins

# Create pull request

curl -s -H "Authorization: token 72c15752b8eb9f084ae2b1dbd3c4989a3446f469" https://api.github.com/repos/duydoxuan/test-ray/pulls/
