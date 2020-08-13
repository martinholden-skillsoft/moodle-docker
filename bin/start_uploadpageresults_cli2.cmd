@ECHO OFF

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle CLI Script: admin/tool/uploadpageresults/cli/uploadpageresults.php
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/tool/uploadpageresults/cli/uploadpageresults.php --help
echo.