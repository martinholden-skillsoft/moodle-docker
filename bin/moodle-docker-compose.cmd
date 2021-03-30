@ECHO OFF
echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Version: %MOODLE_VERSION%
echo *** Moodle DB: %MOODLE_DOCKER_DB%
echo *** Moodle PHP: %MOODLE_DOCKER_PHP_VERSION%
echo.

IF NOT EXIST "%MOODLE_DOCKER_WWWROOT%" (
    ECHO Error: MOODLE_DOCKER_WWWROOT is not set or not an existing directory
    EXIT /B 1
)

IF "%MOODLE_DOCKER_DB%"=="" (
    SET MOODLE_DOCKER_DB=pgsql
)

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD
SET ASSETDIR=%BASEDIR%\assets

SET COMPOSE_CONVERT_WINDOWS_PATHS=true

SET DOCKERCOMPOSE=docker-compose -f "%BASEDIR%\base.yml"
SET DOCKERCOMPOSE=%DOCKERCOMPOSE% -f "%BASEDIR%\service.mail.yml"

IF "%MOODLE_DOCKER_PHP_VERSION%"=="" (
    SET MOODLE_DOCKER_PHP_VERSION=7.4
)

SET DOCKERCOMPOSE=%DOCKERCOMPOSE% -f "%BASEDIR%\db.%MOODLE_DOCKER_DB%.yml"

SET filename=%BASEDIR%\db.%MOODLE_DOCKER_DB%.%MOODLE_DOCKER_PHP_VERSION%.yml
if exist %filename% (
    SET DOCKERCOMPOSE=%DOCKERCOMPOSE% -f "%filename%"
)

IF NOT "%MOODLE_DOCKER_BROWSER%"=="" (
    IF NOT "%MOODLE_DOCKER_BROWSER%"=="firefox" (
        SET DOCKERCOMPOSE=%DOCKERCOMPOSE% -f "%BASEDIR%\selenium.%MOODLE_DOCKER_BROWSER%.yml"
    )
)

IF NOT "%MOODLE_DOCKER_PHPUNIT_EXTERNAL_SERVICES%"=="" (
    SET DOCKERCOMPOSE=%DOCKERCOMPOSE% -f "%BASEDIR%\phpunit-external-services.yml"
)

IF "%MOODLE_SOLR%"==1 (
    SET DOCKERCOMPOSE=%DOCKERCOMPOSE% -f "%BASEDIR%\solr.yml"
)

IF "%MOODLE_DOCKER_WEB_HOST%"=="" (
    SET MOODLE_DOCKER_WEB_HOST=localhost
)

IF "%MOODLE_DOCKER_WEB_PORT%"=="" (
    SET MOODLE_DOCKER_WEB_PORT=8000
)

SET "TRUE="
IF NOT "%MOODLE_DOCKER_WEB_PORT%"=="%MOODLE_DOCKER_WEB_PORT::=%" SET TRUE=1
IF NOT "%MOODLE_DOCKER_WEB_PORT%"=="0" SET TRUE=1
IF DEFINED TRUE (
    REM If no bind ip has been configured (bind_ip:port), default to 127.0.0.1
    IF "%MOODLE_DOCKER_WEB_PORT%"=="%MOODLE_DOCKER_WEB_PORT::=%" (
        SET MOODLE_DOCKER_WEB_PORT=127.0.0.1:%MOODLE_DOCKER_WEB_PORT%
    )
    SET DOCKERCOMPOSE=%DOCKERCOMPOSE% -f "%BASEDIR%\webserver.port.yml"
)

IF "%MOODLE_DOCKER_SELENIUM_VNC_PORT%"=="" (
    SET MOODLE_DOCKER_SELENIUM_SUFFIX=
) ELSE (
    SET "TRUE="
    IF NOT "%MOODLE_DOCKER_SELENIUM_VNC_PORT%"=="%MOODLE_DOCKER_SELENIUM_VNC_PORT::=%" SET TRUE=1
    IF NOT "%MOODLE_DOCKER_SELENIUM_VNC_PORT%"=="0" SET TRUE=1
    IF DEFINED TRUE (
        SET MOODLE_DOCKER_SELENIUM_SUFFIX=-debug
        SET DOCKERCOMPOSE=%DOCKERCOMPOSE% -f "%BASEDIR%\selenium.debug.yml"
        REM If no bind ip has been configured (bind_ip:port), default to 127.0.0.1
        IF "%MOODLE_DOCKER_SELENIUM_VNC_PORT%"=="%MOODLE_DOCKER_SELENIUM_VNC_PORT::=%" (
            SET MOODLE_DOCKER_SELENIUM_VNC_PORT=127.0.0.1:%MOODLE_DOCKER_SELENIUM_VNC_PORT%
        )
    )
)

%DOCKERCOMPOSE% %*
