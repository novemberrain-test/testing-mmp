
#!/bin/bash



#config user
git config --global user.name "jenkins"
git config --global user.email "jenkins@humana.com"

git checkout jenkins

git add .
git commit -am "test"
git push origin




