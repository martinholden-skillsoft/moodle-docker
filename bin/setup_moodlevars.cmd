@ECHO OFF
:: the first parameter is an optional version
IF "%1"=="" ( SET "MOODLE_VERSION=MOODLE_39_STABLE" ) ELSE ( SET "MOODLE_VERSION=%1" )
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

