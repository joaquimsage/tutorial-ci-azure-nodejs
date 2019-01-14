@echo off
REM THIS SCRIPT IS BEING USED FROM THE BUILD "LOCK-RELEASE-DEVELOPMENT-TO-QA", WITHIN THE FIRST STEP-------------

ECHO SOURCE BRANCH IS %BUILD_SOURCEBRANCH%
IF %BUILD_SOURCEBRANCH% == refs/heads/master (
   ECHO You can not release based on this branch. Try develop or BOTS-000, fix, etc.
   EXIT
)

REM The source branch is QA
SET sourceBranch=origin/%BUILD_SOURCEBRANCH:refs/heads/=%
REM The source branch is develop, BOTS-000, fix.develop, etc.
SET developBranch=%~1
SET developCiBranch=develop-ci
SET QAbranch=QA


ECHO GIT STATUS
git status

ECHO GIT CONFIG
git config --global user.email "joaquim.forcada@sage.com"
git config --global user.name "CI Auto-process"

REM SYNCHRONIZE SOURCE BRANCH (develop?) WITH develop-ci:-----------------------------
ECHO Trying to git checkout %developBranch% (develop, BOTS-000, fix.develop, etc.)
git checkout %developBranch%
ECHO GIT PULL %developBranch%
git pull origin
ECHO GIT MERGE DEVELOP-CI
git merge origin/%developCiBranch%
ECHO GIT PUSH into DEVELOP
git push origin %developBranch%
ECHO GIT STATUS
git status

REM SYNCHRONIZE develop-ci WITH qa AND VICEVERSA:--------------------------------------
ECHO Trying to git checkout %developCiBranch%
git checkout %developCiBranch%
ECHO Trying to pull REMOTE develop-ci
git pull origin %developCiBranch%
ECHO Trying to merge QA into develop-ci
git merge origin/%QAbranch%
ECHO Trying to push back remote origin/develop-ci
git push origin %developCiBranch%
ECHO GIT STATUS
git status
REM QA VICEVERSA:--------------------------------------
git checkout %QAbranch%
git merge %developCiBranch%
ECHO GIT PUSH QA
git push origin %QAbranch%
ECHO GIT STATUS
git status

REM TAGGING CHECK:------------------------------------
echo GIT TAG history
git tag -l

echo Last Tag via describe, the one that release-it will find:
git describe --abbrev=0  --tags

