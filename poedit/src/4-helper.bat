@echo off

rem -------------------------------------------------------------
rem  Build and test package for chocolatey.
rem -------------------------------------------------------------

@SetLocal EnableExtensions EnableDelayedExpansion

set "TIMEOUT=55"
set "KEY_LIST=YNC"
set "YES_KEY=Y"
set "NO_KEY=N"
set "DEFAULT_KEY=%YES_KEY%"

call 1-build-package.bat 1
call :functions_yesOrNot "You have execute Test script? " 2-test-package.bat
call :functions_yesOrNot "You have execute Push script? " 3-push-package.bat

goto end

:functions_yesOrNot
set MESSAGE_TEXT=[Y/Yes,N/No,C/Cancel]:
CHOICE /C %KEY_LIST% /D %YES_KEY% /T %TIMEOUT% /M %1%MESSAGE_TEXT% /N
if %ERRORLEVEL% == 1 (
	call %2 1
)
if %ERRORLEVEL% == 3 (
	goto end
)
exit /b

:end
pause

@endlocal