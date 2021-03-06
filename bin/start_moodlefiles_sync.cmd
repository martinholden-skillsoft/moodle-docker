@ECHO OFF
echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo *** Parameters: %*
echo.
echo *** Moodle Version: %MOODLE_VERSION%
echo *** Moodle DB: %MOODLE_DOCKER_DB%
echo *** Moodle PHP: %MOODLE_DOCKER_PHP_VERSION%
echo *** Moodle Web Root: %MOODLE_DOCKER_WWWROOT%
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD

echo.
echo *** Ensure moodle files from %BASEDIR%\assets\moodle_files\ are installed
echo.
XCOPY %BASEDIR%\assets\moodle_files\* %MOODLE_DOCKER_WWWROOT%\ /s /i /y
echo.
