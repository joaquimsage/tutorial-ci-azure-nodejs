@echo off
# THIS SCRIPT IS BEING USED FROM THE BUILD "LOCK-RELEASE-DEVELOPMENT-TO-QA", WITHIN THE 2nd STEP-------------

SET QAbranch=QA
SET developBranch=develop
SET developCiBranch=develop-ci

ECHO SOURCE BRANCH IS %BUILD_SOURCEBRANCH%
IF %BUILD_SOURCEBRANCH% NEQ refs/heads/%QAbranch% (
   ECHO You can not release based on this branch %BUILD_SOURCEBRANCH%. Try setting QA branch instead
   EXIT
)

ECHO GIT STATUS
git status

ECHO git checkout SOURCEBRANCH
git checkout %BUILD_SOURCEBRANCH:refs/heads/=%

ECHO GIT LOG -2
git log -2

ECHO GIT CONFIG
git config --global user.email "joaquim.forcada@sage.com"
git config --global user.name "CI Auto-process"

ECHO Trying to git checkout develop
git checkout %developBranch%

ECHO GIT MERGE QA
# Add squash?
git merge %BUILD_SOURCEBRANCH:refs/heads/=%

ECHO GIT PUSH ORIGIN DEVELOP
git push origin %developBranch%

ECHO GIT LOG -2
git log -2

ECHO GIT STATUS
git status

ECHO Trying to git checkout develop-ci
git checkout %developCiBranch%

ECHO GIT MERGE QA
# Add squash?
git merge %BUILD_SOURCEBRANCH:refs/heads/=%

ECHO GIT PUSH ORIGIN DEVELOP
git push origin %developCiBranch%

ECHO GIT LOG -2
git log -2

ECHO GIT STATUS
git status