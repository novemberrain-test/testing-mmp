
#!/bin/bash
user_name=$1
password=$2

#config user
git config --global user.name "jenkins"
git config --global user.email "jenkins@gmail.com"


git add .
git commit -am "test"
git push "https://${user_name}:${password}@github.com/novemberrain-test/test-ray.git" jenkins




