@ECHO OFF

@ECHO OFF
:: the first parameter is an optional version
IF "%1"=="" ( SET "MOODLE_DOCKER_PHP_VERSION=7.2" ) ELSE ( SET "MOODLE_DOCKER_PHP_VERSION=%1" )

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Bring up the Docker containers
echo.
call %BASEDIR%\bin\moodle-docker-compose up -d
echo.

echo.
echo *** Run the Moodle CLI script: admin/cli/install_database.php
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver php admin/cli/install_database.php --agree-license --fullname="Docker moodle" --shortname="docker_moodle" --adminpass="test" --adminemail="admin@example.com"
echo.

echo.
echo *** Moodle is running please. Browse to - http://%MOODLE_DOCKER_WEB_PORT%
echo *** Moodle Admin Username: admin
echo *** Moodle Admin password: test
echo.

IF "%MOODLE_DOCKER_DB%"=="pgsql" (
	echo.
	echo *** pgAdmin4 is running please. Browse to - http://127.0.0.1:5050
	echo *** pgAdmin4 User: user@domain.com
	echo *** pgAdmin4 Password: SuperSecret
	echo.
	echo *** Moodle Database Username: moodle
	echo *** Moodle Database Username: m@0dl3ing
	echo.
)