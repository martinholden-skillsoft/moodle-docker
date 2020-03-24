@ECHO OFF

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo.
echo *** Moodle Version: %MOODLE_VERSION%
echo *** Moodle DB: %MOODLE_DOCKER_DB%
echo *** Moodle PHP: %MOODLE_DOCKER_PHP_VERSION%
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Bring down the Docker containers
echo.
call %BASEDIR%\bin\moodle-docker-compose down
echo.
