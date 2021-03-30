@ECHO OFF
:: the first parameter is an optional version
IF "%MOODLE_DOCKER_PHP_VERSION%"=="" ( SET "MOODLE_DOCKER_PHP_VERSION=7.4" )

echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Version: %MOODLE_VERSION%
echo *** Moodle DB: %MOODLE_DOCKER_DB%
echo *** Moodle PHP: %MOODLE_DOCKER_PHP_VERSION%
echo.


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
echo *** Get Webserverdev Container ID
echo.
docker container ls -aqf name=webserverdev > containerid.txt
set /p containerid=<containerid.txt
echo %containerid%

echo.
echo *** Copy extra PHP configuration to webserverdev
echo.
docker cp docker-php-limits.ini %containerid%:/usr/local/etc/php/conf.d/docker-php-limits.ini
echo.

echo.
echo *** Restart Apache
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev bash -c "/etc/init.d/apache2 reload"
echo.

echo.
echo *** Run the Moodle CLI script: admin/cli/install_database.php
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserverdev php admin/cli/install_database.php --agree-license --fullname="Docker moodle" --shortname="docker_moodle" --adminpass="test" --adminemail="admin@example.com"
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

IF "%MOODLE_DOCKER_DB%"=="MYSQL" (
	echo.
	echo *** phpMyadmin is running please. Browse to - http://127.0.0.1:5050
	echo.
	echo *** Moodle Database Username: moodle
	echo *** Moodle Database Username: m@0dl3ing
	echo.
)

IF "%MOODLE_DOCKER_DB%"=="MARIADB" (
	echo.
	echo *** phpMyadmin is running please. Browse to - http://127.0.0.1:5050
	echo.
	echo *** Moodle Database Username: moodle
	echo *** Moodle Database Username: m@0dl3ing
	echo.
)