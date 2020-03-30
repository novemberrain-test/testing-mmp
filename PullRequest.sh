
#!/bin/bash



#config user
git config --global user.name "duydoxuan"
git config --global user.email "duydxbit@gmail.com"

git checkout jenkins

git add .
git commit -am "test"
git push origin jenkins




