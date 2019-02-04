@echo off
set sc=c:\windows\system32\sc.exe
%sc% stop beep
rem The space between "start=" and "demand" is required. :-/
%sc% sc config beep start= demand
