@ECHO OFF
:: the first parameter is a required BEHAT_TAG
IF "%1"=="" ( SET "BEHAT_TAG=UNKNOWN" ) ELSE ( SET "BEHAT_TAG=%1" )

IF "%BEHAT_TAG%"=="UNKNOWN" (
    ECHO Error: BEHAT_TAG is not set
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

echo.
echo *** Moodle CLI Script: admin/tool/behat/cli/run.php --tags=%BEHAT_TAG% --format="pretty"
call %BASEDIR%\bin\moodle-docker-compose exec -u www-data webserverdev php admin/tool/behat/cli/run.php --tags=%BEHAT_TAG% --format="pretty"
echo.


