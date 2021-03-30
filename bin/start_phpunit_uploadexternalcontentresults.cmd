@ECHO OFF

echo.
echo **************************************************
echo *** Running: PHP Unit Tests for tool_uploadexternalcontentresults
echo *** Parameters: %*
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

:: Get the rest of the optional command line after first two arguments
SHIFT
SHIFT
SET PHPUNITOPTIONS=%1

echo.
echo *** Moodle CLI Script: admin/tool/phpunit/cli/init.php
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev php admin/tool/phpunit/cli/init.php
echo.

echo.
echo *** Moodle CLI Script: vendor/bin/phpunit %PHPUNITOPTIONS% tool_uploadexternalcontentresults_importer_testcase admin/tool/uploadexternalcontentresults/tests/importer_test.php
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev vendor/bin/phpunit %PHPUNITOPTIONS% tool_uploadexternalcontentresults_importer_testcase admin/tool/uploadexternalcontentresults/tests/importer_test.php
echo.
