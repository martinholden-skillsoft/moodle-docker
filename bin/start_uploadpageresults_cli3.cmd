@ECHO OFF
:: the first parameter is an optional filename
IF "%1"=="" ( SET "MOODLE_UPLOAD_COMPLETIONFILE=admin/tool/uploadpageresults/tests/fixtures/notenoughcolumns.csv" ) ELSE ( SET "MOODLE_UPLOAD_COMPLETIONFILE=%1" )


echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Upload File: %MOODLE_UPLOAD_COMPLETIONFILE%
echo *** Moodle CLI Script: admin/tool/uploadpageresults/cli/uploadpageresults.php
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/tool/uploadpageresults/cli/uploadpageresults.php --source=../../../../%MOODLE_UPLOAD_COMPLETIONFILE%
echo.