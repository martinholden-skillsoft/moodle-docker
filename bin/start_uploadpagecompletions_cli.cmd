@ECHO OFF
:: the first parameter is an optional filename
IF "%1"=="" ( SET "MOODLE_UPLOAD_COMPLETIONFILE=moodle_results.csv" ) ELSE ( SET "MOODLE_UPLOAD_COMPLETIONFILE=%1" )

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Run the Moodle CLI script: admin/tool/uploadpagecompletions/cli/uploadpagecompletions.php
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/tool/uploadpagecompletions/cli/uploadpagecompletions.php --source=../../../../%MOODLE_UPLOAD_COMPLETIONFILE%
echo.