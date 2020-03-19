@ECHO OFF

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Run the Moodle CLI script: admin/tool/uploadpagecompletions/cli/uploadpagecompletions.php
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/tool/uploadpagecompletions/cli/uploadpagecompletions.php --source=../../../../moodle_results.csv
echo.