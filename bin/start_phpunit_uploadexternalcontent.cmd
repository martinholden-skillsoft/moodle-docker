@ECHO OFF

echo.
echo **************************************************
echo *** Running: PHP Unit Tests for tool_uploadexternalcontent
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
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/tool/phpunit/cli/init.php
echo.

echo.
echo *** Moodle CLI Script: vendor/bin/phpunit %PHPUNITOPTIONS% tool_uploadexternalcontent_importer_testcase admin/tool/uploadexternalcontent/tests/importer_test.php
call %BASEDIR%\bin\moodle-docker-compose exec webserver vendor/bin/phpunit %PHPUNITOPTIONS% tool_uploadexternalcontent_importer_testcase admin/tool/uploadexternalcontent/tests/importer_test.php
echo.
