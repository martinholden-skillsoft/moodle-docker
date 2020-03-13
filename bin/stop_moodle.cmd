@ECHO OFF

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Bring down the Docker containers
echo.
call %BASEDIR%\bin\moodle-docker-compose down
echo.
