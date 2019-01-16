#!/usr/bin/env bash
@echo off
# THIS SCRIPT IS BEING USED FROM THE BUILD "LOCK-RELEASE-DEVELOPMENT-TO-QA", WITHIN THE FIRST STEP-------------
echo GIT CONFIG
git config --global user.email "joaquim.forcada@sage.com"
git config --global user.name "CI Auto-process"


# The source branch is develop, BOTS-000, fix.develop, etc.
QAbranch=QA
developBranch=develop
developCiBranch=develop-ci

echo GIT STATUS
git status

# SYNCHRONIZE SOURCE BRANCH (develop?) WITH develop-ci:-----------------------------
echo Trying to git checkout ${developBranch}
git checkout ${developBranch}
echo GIT PULL ${developBranch}
git pull origin ${developBranch}
echo GIT MERGE DEVELOP-CI
git merge origin/${developCiBranch}
echo GIT PUSH into DEVELOP
git push origin ${developBranch}
echo GIT STATUS
git status

# SYNCHRONIZE develop-ci WITH develop and QA AND VICEVERSA:--------------------------------------
echo Trying to git checkout ${developCiBranch}
git checkout ${developCiBranch}
git merge ${developBranch}

echo Trying to merge QA into develop-ci
git merge origin/${QAbranch}
echo Trying to push back remote origin/develop-ci
git push origin ${developCiBranch}
echo GIT STATUS
git status

# QA VICEVERSA:--------------------------------------
git checkout ${QAbranch}
git merge ${developCiBranch}
# echo GIT PUSH QA
# git push origin ${QAbranch}
echo GIT STATUS
git status

# TAGGING CHECK:------------------------------------
# echo GIT TAG history
# git tag -l


