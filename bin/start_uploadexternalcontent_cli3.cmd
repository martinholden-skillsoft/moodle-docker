@ECHO OFF

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle CLI Script: admin/tool/uploadexternalcontent/cli/uploadexternalcontent.php
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev php admin/tool/uploadexternalcontent/cli/uploadexternalcontent.php --help
echo.