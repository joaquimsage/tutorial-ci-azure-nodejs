#!/usr/bin/env bash
@echo off
# THIS SCRIPT IS BEING USED FROM THE BUILD "LOCK-RELEASE-DEVELOPMENT-TO-QA", WITHIN THE 2nd STEP-------------
echo GIT CONFIG
git config --global user.email "joaquim.forcada@sage.com"
git config --global user.name "CI Auto-process"


# The source branch is QA-----------------------------------------
QAbranch=QA

echo Reset and Checkout QA branch:---------
git reset --hard
git checkout ${QAbranch}

# THIS SCRIPT IS BEING USED FROM THE BUILD "RELEASE-QA-to-PRODUCTION"-------------
previousVersion=`git describe --abbrev=0 --tags`
previousVersionBranch=version/${previousVersion}

echo The current version is ${previousVersion}

# CREATE NEW VERSION BRANCH TO DELIVER to LSM:------------------------------------
git status

