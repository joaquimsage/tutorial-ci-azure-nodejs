#!/usr/bin/env bash
@echo off
# THIS SCRIPT IS BEING USED FROM THE BUILD "LOCK-RELEASE-DEVELOPMENT-TO-QA", WITHIN THE 2nd STEP-------------
echo GIT CONFIG
git config --global user.email "joaquim.forcada@sage.com"
git config --global user.name "CI Auto-process"

QAbranch=QA
developBranch=develop
developCiBranch=develop-ci

echo GIT STATUS
git status

echo git checkout develop
git checkout ${developBranch}


echo Trying to git checkout develop
git checkout ${developBranch}

echo GIT MERGE QA
# Add squash?
git merge ${QAbranch}

echo GIT PUSH ORIGIN DEVELOP
git push origin ${developBranch}


echo GIT STATUS
git status

echo Trying to git checkout develop-ci
git checkout ${developCiBranch}

echo GIT MERGE QA
# Add squash?
git merge ${QAbranch}

echo GIT PUSH ORIGIN DEVELOP
git push origin ${developCiBranch}


echo GIT STATUS
git status

echo Trying to git checkout QA
git checkout ${QAbranch}