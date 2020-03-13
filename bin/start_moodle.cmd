@ECHO OFF

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