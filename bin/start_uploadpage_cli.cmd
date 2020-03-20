@ECHO OFF
:: the first parameter is an optional filename
IF "%1"=="" ( SET "MOODLE_UPLOAD_FILE=moodle_channels.csv" ) ELSE ( SET "MOODLE_UPLOAD_FILE=%1" )
:: the second parameter is an optional categoryid
IF "%2"=="" ( SET "MOODLE_UPLOAD_CATEGORYID=1" ) ELSE ( SET "MOODLE_UPLOAD_CATEGORYID=%1" )

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD



echo.
echo *** Run the Moodle CLI script: admin/tool/uploadpage/cli/uploadpage.php
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/tool/uploadpage/cli/uploadpage.php --source=../../../../%MOODLE_UPLOAD_FILE% --categoryid=%MOODLE_UPLOAD_CATEGORYID%
echo.