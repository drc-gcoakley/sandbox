Set shell = WScript.CreateObject("WScript.Shell")  
Set venv = shell.Environment("Volatile")  

scriptingHost = LCase(Right(Wscript.FullName,Len("cscript.exe")))
interactive = Wscript.Interactive And (scriptingHost = "cscript.exe")

If interactive Then 
  Wscript.Echo "SCRIPT start variables"
  Wscript.Echo "  ScriptingHost = " & scriptingHost
  Wscript.Echo "  FullName = " & Wscript.FullName
  Wscript.Echo "  ScriptFullName = " & Wscript.ScriptFullName
  
  Call showVolatile()
End If

rem Many paths under these registry keys should be changed.
rem HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
rem HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
rem C:\Users\gcoakley\AppData\Roaming\Microsoft\Windows\Libraries

Wscript.Quit(0)


Sub showVolatile()
  Wscript.Echo "VOLATILE ENVIRONMENT settings in registry"
  Wscript.Echo "  USERPROFILE = " & venv("USERPROFILE")  
  Wscript.Echo "      APPDATA = " & venv("APPDATA")  
  Wscript.Echo " LOCALAPPDATA = " & venv("LOCALAPPDATA")  
  Wscript.Echo "    HOMEDRIVE = " & venv("HOMEDRIVE")  
  Wscript.Echo "     HOMEPATH = " & venv("HOMEPATH")  
  Wscript.Echo "    HOMESHARE = " & venv("HOMESHARE")  
End Sub
