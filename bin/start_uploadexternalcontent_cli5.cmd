@ECHO OFF
:: the first parameter is an optional filename
IF "%1"=="" ( SET "MOODLE_UPLOAD_FILE=admin/tool/uploadexternalcontent/tests/fixtures/onecoursetab.txt" ) ELSE ( SET "MOODLE_UPLOAD_FILE=%1" )
:: the second parameter is an optional categoryid
IF "%2"=="" ( SET "MOODLE_UPLOAD_CATEGORYID=1" ) ELSE ( SET "MOODLE_UPLOAD_CATEGORYID=%1" )

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Upload File: %MOODLE_UPLOAD_FILE%
echo *** Moodle Upload Category Id: %MOODLE_UPLOAD_CATEGORYID%
echo *** Moodle CLI Script: admin/tool/uploadexternalcontent/cli/uploadexternalcontent.php
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev php admin/tool/uploadexternalcontent/cli/uploadexternalcontent.php --source=../../../../%MOODLE_UPLOAD_FILE% --categoryid=%MOODLE_UPLOAD_CATEGORYID%
echo.