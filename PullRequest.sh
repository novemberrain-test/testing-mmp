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
curl -X POST --user "${user_name}:${password}"  -k \
  -d '{"title": "jenkins update sprint, version","head": "octocat:new-feature","base": "master"}' \
  https://api.github.com/repos/garoudan/foo/pulls 




