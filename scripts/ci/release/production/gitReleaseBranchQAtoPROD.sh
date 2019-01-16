#!/usr/bin/env bash
@echo off
# THIS SCRIPT IS BEING USED FROM THE BUILD "LOCK-RELEASE-DEVELOPMENT-TO-QA", WITHIN THE 2nd STEP-------------
echo GIT CONFIG
git config --global user.email "joaquim.forcada@sage.com"
git config --global user.name "CI Auto-process"


# The source branch is develop, BOTS-000, fix.develop, etc.
QAbranch=QA
developBranch=develop


git checkout ${QAbranch}

# THIS SCRIPT IS BEING USED FROM THE BUILD "RELEASE-QA-to-PRODUCTION"-------------
newLastTag=`git describe --abbrev=0 --tags`
newLastTagBranch=version/${newLastTag}

# CREATE NEW VERSION BRANCH TO DELIVER to LSM:
git checkout -b version/${newLastTag}
git push --no-verify origin version/${newLastTag}
git status


# SYNCHRONIZE VERSION.X.Y.Z with DEVELOP:-----------------------------
echo Trying to git checkout ${developBranch}
git checkout ${developBranch}
echo GIT PULL ${developBranch}
git pull origin ${developBranch}
git merge version/${newLastTag}
echo GIT PUSH into DEVELOP
git push origin ${developBranch}
echo GIT STATUS
git status

git checkout ${QAbranch}
echo GIT STATUS
git status
