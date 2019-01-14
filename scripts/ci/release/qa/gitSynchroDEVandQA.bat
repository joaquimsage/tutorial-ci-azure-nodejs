@echo off
# THIS SCRIPT IS BEING USED FROM THE BUILD "LOCK-RELEASE-DEVELOPMENT-TO-QA", WITHIN THE FIRST STEP-------------

ECHO SOURCE BRANCH IS %BUILD_SOURCEBRANCH%
IF %BUILD_SOURCEBRANCH% == refs/heads/master (
   ECHO You can not release based on this branch. Try develop or BOTS-000, fix, etc.
   EXIT
)

# The source branch is QA
SET sourceBranch=origin/%BUILD_SOURCEBRANCH:refs/heads/=%
# The source branch is develop, BOTS-000, fix.develop, etc.
SET developBranch=%~1
SET developCiBranch=develop-ci
SET QAbranch=QA


ECHO GIT STATUS
git status

#ECHO GIT CONFIG
#git config --global user.email "joaquim.forcada@sage.com"
#git config --global user.name "CI Auto-process"

# SYNCHRONIZE SOURCE BRANCH (develop?) WITH develop-ci:-----------------------------
ECHO Trying to git checkout %developBranch% (develop, BOTS-000, fix.develop, etc.)
git checkout %developBranch%
ECHO GIT PULL %developBranch%
git pull origin
ECHO GIT MERGE DEVELOP-CI
git merge origin/%developCiBranch%
ECHO GIT PUSH
git push origin %developBranch%
ECHO GIT STATUS
git status

# SYNCHRONIZE develop-ci WITH qa AND VICEVERSA:--------------------------------------
ECHO Trying to git checkout %developCiBranch%
git checkout %developCiBranch%
git pull origin %developCiBranch%
git merge origin/%QAbranch%
git push origin %developCiBranch%
ECHO GIT STATUS
git status
# QA VICEVERSA:--------------------------------------
git checkout %QAbranch%
git merge %developCiBranch%
ECHO GIT PUSH QA
git push origin %QAbranch%
ECHO GIT STATUS
git status

echo GIT CHECKOUT %QAbranch% *********************************************************
git checkout %QAbranch%

echo GIT TAG history
git tag -l

echo Last Tag via describe, the one that release-it will find:
git describe --abbrev=0  --tags

