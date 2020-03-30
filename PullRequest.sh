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

# curl -X POST -k -u $user_name:$password -H "Content-Type: application/json"  -d '{"title": "jenkins update sprint, version","head": "octocat:new-feature","base": "master"}' https://api.github.com/repos/duydoxuan/test-ray/pulls/

curl -v -u 'duydoxuan':'duy@2708' -H "Content-Type:application/json" -X POST https://api.github.com/repos/duydoxuan/test-ray/pulls -d '{"title":"[new module] azure_rm_mysqldatabase", "body": "##### SUMMARY\nAdding support for Azure SQL Databases\n\n##### ISSUE TYPE\n - New Module Pull Request\n\n##### COMPONENT NAME\n\nazure_rm_sql_databases\n\n##### ANSIBLE VERSION\n\n 2.4\n\n##### ADDITIONAL INFORMATION\n\n", "head": "VSChina:azure_rm_mysqldatabase", "base": "master"}