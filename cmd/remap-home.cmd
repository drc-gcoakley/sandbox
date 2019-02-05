@echo off
echo | date > %~dp0\remap-home.log

set SET_VARS=no
if /I "%USERPROFILE%" NEQ "c:\home\gcoakley" set SET_VARS=yes
if /I "%APPDATA%" NEQ "c:\home\gcoakley\AppData\Roaming" set SET_VARS=yes

if "%_HOMESHARE_%" == "" set _HOMESHARE_=%HOMESHARE%
set HOMESHARE=
net use /delete h:

if "%SET_VARS%" == "yes" (
	echo Remapping USERPROFILE from %USERPROFILE% to C:\home\gcoakley
	set USER="gcoakley"
	:: Set HOME variables to a local environment.
	set HOME="C:\home\%USER%"
	set USERPROFILE="%HOME%"
rem This seems to be reverted with different triggers than the USERPROFILE variable and 
rem I have not figured out what yet.
	rem	Most apps seem to use Roaming so, we should set this also.
	set APPDATA="%HOME%\AppData\Roaming"
	set LOCALAPPDATA="%HOME%\AppData\Local"
	
	:: Set variable in the local user account.
	setx HOME "%HOME%"
	setx USERPROFILE "%HOME%"
	rem Most apps seem to use Roaming so, we should set this also.
	setx APPDATA "%HOME%\AppData\Roaming"
	setx LOCALAPPDATA "%HOME%\AppData\Local"

	cscript %~dp0\remap-home.vbs
) else (
	echo USERPROFILE is set as desired.
)

set | sort | %WINDIR%\SYSTEM32\find "\Users\"
echo.

