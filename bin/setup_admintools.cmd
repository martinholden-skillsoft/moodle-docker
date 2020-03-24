@ECHO OFF
echo.
echo **************************************************
echo *** Running: %~n0%~x0
echo.
echo *** Moodle Version: %MOODLE_VERSION%
echo *** Moodle DB: %MOODLE_DOCKER_DB%
echo *** Moodle PHP: %MOODLE_DOCKER_PHP_VERSION%
echo.

PUSHD %cd%
CD %~dp0..
SET BASEDIR=%cd%
POPD
md %BASEDIR%\assets\
md %BASEDIR%\assets\moodle_files
SET MOODLE_DOCKER_ASSETFILES=%BASEDIR%\assets\moodle_files

SET NUL=NUL
IF "%OS%"=="Windows_NT" SET NUL=
IF EXIST %MOODLE_DOCKER_ASSETFILES%\admin\tool\%NUL% GOTO FETCH

:CLONE
echo.
echo *** Cloning Moodle tools - uploadpage
echo.
md %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpage
git clone --branch master --depth 1 --single-branch https://github.com/lushonline/moodle-tool_uploadpage %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpage
echo.
echo *** Cloning Moodle tools - uploadpagecompletions
echo.
md %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpagecompletions
git clone --branch master --depth 1 --single-branch https://github.com/lushonline/moodle-tool_uploadpagecompletions %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpagecompletions
echo.
GOTO FINISH

:FETCH
PUSHD %cd%
CD %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpage
echo.
echo *** Remove all uncommited local files in %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpage
echo.
git clean -df
git clean -df
echo.
echo *** Reset in %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpage
echo.
git reset --hard
echo.
echo *** Fetch any updates
echo.
git fetch --all
echo.
echo *** Show Git Status
echo.
git status
echo.
CD %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpagecompletions
echo.
echo *** Remove all uncommited local files in %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpagecompletions
echo.
git clean -df
git clean -df
echo.
echo *** Reset in %MOODLE_DOCKER_ASSETFILES%\admin\tool\uploadpagecompletions
echo.
git reset --hard
echo.
echo *** Fetch any updates
echo.
git fetch --all
echo.
echo *** Show Git Status
echo.
git status
echo.
POPD

:FINISH

