@echo on

set USER=gcoakley

rem Save existing settings.
if /I not "%USERPROFILE%" == "C:\home\%USER%" (
	dev\bin\cygwin64\bin\date > %~dp0\remap-home.log

	:: Set HOME variables to a local environment.
	set HOMEDRIVE=C:
	set HOMEPATH=\home\%USER%
	set HOME_SHARE=%HOMESHARE%
	set HOMESHARE=\\localhost\C$\home\%USER%
	set HOME=%HOMEDRIVE%%HOMEPATH%
	set USERPROFILE=%HOME%
	rem	Most apps seem to use Roaming so, we should set this also.
	set APPDATA=%HOME%\AppData\Roaming
	set LOCALAPPDATA=%HOME%\AppData\Local

rem This seems to be reverted with different triggers than the USERPROFILE variable and 
rem I have not figured out what yet.
rem	:: Most apps seem to use Roaming so, we should set this also.
rem	set APPDATA=%USERPROFILE%\AppData\Roaming
rem	set LOCALAPPDATA=%USERPROFILE%\AppData\Local
	
	:: Set variable in the local user account.
	setx HOMEDRIVE %HOMEDRIVE%
	setx HOMEPATH  %HOMEPATH%
	setx HOMESHARE %HOMESHARE%
	setx HOME_SHARE %HOME_SHARE%
	setx HOME %HOME%
	setx USERPROFILE %HOME%
rem This seems to be reverted with different triggers than the USERPROFILE variable and 
rem I have not figured out what yet.
	rem Most apps seem to use Roaming so, we should set this also.
	setx APPDATA %HOME%\AppData\Roaming
	setx LOCALAPPDATA %HOME%\AppData\Local
	
	:: Set variable in the system.
	::setx /m HOMEDRIVE %HOMEDRIVE%
	::setx /m HOMEPATH  %HOMEPATH%
	::setx /m HOMESHARE %HOMESHARE%
	::setx /m HOME_SHARE %HOME_SHARE%
	::setx /m HOME %HOME%
	::::setx /m USERPROFILE %USERPROFILE%

	rem Map a drive letter to the home directory.
	rem net use h: /delete
	rem net use h: %HOMESHARE%
	
	cscript %~dp0\remap-home-all.vbs
)

set | sort | find "\Users\"
set | sort | find "gcoakley" | find /v "Path="
