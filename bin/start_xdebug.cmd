@ECHO OFF

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Install XDebug extension with PECL
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver pecl install xdebug
echo.

echo.
echo *** Backup Original docker-php-ext-xdebug.ini on webserver
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver bash -c "cp '/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini' '/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.original'"
echo.

echo.
echo *** Get Webserver Container ID
echo.
docker container ls -aqf name=webserver > containerid.txt
set /p containerid=<containerid.txt
echo %containerid%

echo.
echo *** Copy XDebug extra configuration to webserver
echo.
docker cp docker-php-ext-xdebug-extras.ini %containerid%:/usr/local/etc/php/conf.d/docker-php-ext-xdebug-extras.ini
echo.

echo.
echo *** Enable XDebug extension
echo.
call %BASEDIR%\bin\moodle-docker-compose exec webserver docker-php-ext-enable xdebug
echo.
