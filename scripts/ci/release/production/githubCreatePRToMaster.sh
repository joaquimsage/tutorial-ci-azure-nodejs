#!/usr/bin/env bash
@echo off

# THIS SCRIPT IS BEING USED FROM THE BUILD "LOCK-RELEASE-DEVELOPMENT-TO-QA", WITHIN THE 2nd STEP-------------
echo GIT CONFIG
git config --global user.email "joaquim.forcada@sage.com"
git config --global user.name "CI Auto-process"

QAbranch=QA

echo Reset and Checkout QA branch:---------
# git reset --hard
git checkout ${QAbranch}


# put this in your .bash_profile
pull_request() {
  to_branch=$1
  if [ -z $to_branch ]; then
    to_branch="master"
  fi

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

  echo https://github.com/$to_user/$repo/pull/new/$to_user:$to_branch...$from_user:$from_branch
  open "https://github.com/$to_user/$repo/pull/new/$to_user:$to_branch...$from_user:$from_branch"
}

# usage
pull_request              # PR to master
# pull_request other_branch # PR to other_branch