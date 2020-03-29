
#!/bin/bash

upstream='https://github.com/duydoxuan/test-ray.git'
pull_request() {
  to_branch=$1
  upstreamURL=$2
  BranchOrigin=$3
  if [ -z $to_branch ]; then
    to_branch="master"
  fi
  # fetch latest code
  git remote add upstream $upstreamURL
  git checkout $BranchOrigin
  git fetch upstream
  git merge upstream/master
  # try the upstream branch if possible, otherwise origin will do


  upstream=$(git config --get remote.upstream.url)
  origin=$(git config --get remote.origin.url)
  if [ -z $upstream ]; then
    upstream=$origin
  fi
  
  to_user=$(echo $upstream | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
  from_user=$(echo $origin | sed -e 's/.*[\/:]\([^/]*\)\/[^/]*$/\1/')
  repo=$(basename `git rev-parse --show-toplevel`)
  from_branch=$(git rev-parse --abbrev-ref HEAD)
}
 
# usage
set -x 

pull_request              # PR to master
pull_request other_branch upstreamURL BranchOrigin  # PR to other_branch