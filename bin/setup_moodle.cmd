@ECHO OFF
:: the first parameter is an optional version
IF "%1"=="" ( SET "MOODLE_VERSION=master" ) ELSE ( SET "MOODLE_VERSION=%1" )
IF "%2"=="" ( SET "MOODLE_DOCKER_DB=pgsql" ) ELSE ( SET "MOODLE_DOCKER_DB=%2" )

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Version: %MOODLE_VERSION%
echo *** Moodle DB: %MOODLE_DOCKER_DB%
echo *** Moodle PHP: %MOODLE_DOCKER_PHP_VERSION%
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD
SET MOODLE_DOCKER_WWWROOT=%BASEDIR%\assets\moodle_%MOODLE_VERSION%

SET NUL=NUL
IF "%OS%"=="Windows_NT" SET NUL=
IF EXIST %MOODLE_DOCKER_WWWROOT%\%NUL% GOTO FETCH

:CLONE
echo.
echo *** Cloning Moodle branch: %MOODLE_VERSION%
echo.
git clone --branch %MOODLE_VERSION% --depth 1 --single-branch git://github.com/moodle/moodle %MOODLE_DOCKER_WWWROOT%
echo.
GOTO FINISH

:FETCH
PUSHD %cd%
CD %MOODLE_DOCKER_WWWROOT%
echo.
echo *** Remove all uncommited local files in %MOODLE_DOCKER_WWWROOT%
echo.
git clean -df
git clean -df
git clean -df
echo.
echo *** Reset in %MOODLE_DOCKER_WWWROOT%
echo.
git reset --hard
echo.
echo *** Fetch any updates from branch %MOODLE_VERSION%
echo.
git fetch --all
echo.
echo *** Show Git Status
echo.
git status
echo.
POPD

:FINISH
echo.
echo *** Ensure customized config.php for the Docker containers is in place
echo.
copy config.docker-template.php %MOODLE_DOCKER_WWWROOT%\config.php
echo.

echo.
echo *** Ensure moodle files from %BASEDIR%\assets\moodle_files\ are installed
echo.
XCOPY %BASEDIR%\assets\moodle_files\* %MOODLE_DOCKER_WWWROOT%\ /s /i /y
echo.
