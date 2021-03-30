@ECHO OFF
echo.
echo **************************************************
echo *** Running: PHP Unit Tests for mod_externalcontent
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
echo *** Moodle CLI Script: vendor/bin/phpunit %PHPUNITOPTIONS% mod_externalcontent_lrs_testcase mod/externalcontent/tests/lrs_test.php
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev vendor/bin/phpunit %PHPUNITOPTIONS% mod_externalcontent_lrs_testcase mod/externalcontent/tests/lrs_test.php
echo.
echo *** Moodle CLI Script: vendor/bin/phpunit %PHPUNITOPTIONS% mod_externalcontent_lib_testcase mod/externalcontent/tests/lib_test.php
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev vendor/bin/phpunit %PHPUNITOPTIONS% mod_externalcontent_lib_testcase mod/externalcontent/tests/lib_test.php
echo.
echo *** Moodle CLI Script: vendor/bin/phpunit %PHPUNITOPTIONS% mod_externalcontent_generator_testcase mod/externalcontent/tests/generator_test.php
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev vendor/bin/phpunit %PHPUNITOPTIONS% mod_externalcontent_generator_testcase mod/externalcontent/tests/generator_test.php
echo.
echo *** Moodle CLI Script: vendor/bin/phpunit %PHPUNITOPTIONS% mod_externalcontent_external_testcase mod/externalcontent/tests/externallib_test.php
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev vendor/bin/phpunit %PHPUNITOPTIONS% mod_externalcontent_external_testcase mod/externalcontent/tests/externallib_test.php
echo.