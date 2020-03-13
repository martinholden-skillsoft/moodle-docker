@ECHO OFF
:: the first parameter is an optional version
IF "%1"=="" ( SET "MOODLE_VERSION=master" ) ELSE ( SET "MOODLE_VERSION=%1" )
IF "%2"=="" ( SET "MOODLE_DOCKER_DB=pgsql" ) ELSE ( SET "MOODLE_DOCKER_DB=%2" )

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD
SET MOODLE_DOCKER_WWWROOT=%BASEDIR%\assets\moodle_%MOODLE_VERSION%

SET NUL=NUL
IF "%OS%"=="Windows_NT" SET NUL=
IF EXIST %MOODLE_DOCKER_WWWROOT%\%NUL% GOTO FETCH

:CLONE
git clone --branch %MOODLE_VERSION% --depth 1 --single-branch git://github.com/moodle/moodle %MOODLE_DOCKER_WWWROOT%
GOTO FINISH

:FETCH
git fetch --all
git reset --hard origin/master

:FINISH
REM Ensure customized config.php for the Docker containers is in place
copy config.docker-template.php %MOODLE_DOCKER_WWWROOT%\config.php

echo.
REM Ensure application plugin files are in place
XCOPY moodle_files\* %MOODLE_DOCKER_WWWROOT%\ /s /i /y


