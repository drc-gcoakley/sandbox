@echo off

:: Show existing settings.
echo HOMEDRIVE   %HOMEDRIVE%
echo HOMEPATH    %HOMEPATH%
echo HOMESHARE   %HOMESHARE%
echo HOME        %HOME%
echo USERPROFILE %USERPROFILE%

echo.
echo NETDRIVE    %NETDRIVE%
echo NETPATH     %NETPATH%
echo NETSHARE    %NETSHARE%

echo.
set | grep "^HOME\|^USERPROFILE^NET"
pause
