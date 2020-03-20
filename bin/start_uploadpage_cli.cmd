@ECHO OFF

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Run the Moodle CLI script: admin/tool/uploadpage/cli/uploadpage.php
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/tool/uploadpage/cli/uploadpage.php --source=../../../../moodle_channels.csv --categoryid=1
echo.