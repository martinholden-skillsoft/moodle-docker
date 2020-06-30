@ECHO OFF
:: the first parameter is a required PHPUNIT Testcase
IF "%1"=="" ( SET "PHPUNIT_TESTCASE=UNKNOWN" ) ELSE ( SET "PHPUNIT_TESTCASE=%1" )
:: the first parameter is a required PHPUNIT Testcase
IF "%2"=="" ( SET "PHPUNIT_PATH=UNKNOWN" ) ELSE ( SET "PHPUNIT_PATH=%2" )

IF "%PHPUNIT_TESTCASE%"=="UNKNOWN" (
    ECHO Error: PHPUNIT_TESTCASE is not set
    EXIT /B 1
)

IF "%PHPUNIT_PATH%"=="UNKNOWN" (
    ECHO Error: PHPUNIT_PATH is not set
    EXIT /B 1
)

echo.
echo **************************************************
echo *** Running: %~n0%~x0
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
echo *** Moodle CLI Script: vendor/bin/phpunit %PHPUNITOPTIONS% %PHPUNIT_TESTCASE% %PHPUNIT_PATH%
call %BASEDIR%\bin\moodle-docker-compose exec webserver vendor/bin/phpunit %PHPUNITOPTIONS% %PHPUNIT_TESTCASE% %PHPUNIT_PATH%
echo.
