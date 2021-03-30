@ECHO OFF

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Run the Moodle CLI script: admin/cli/cron.php
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev php admin/cli/cron.php
echo.