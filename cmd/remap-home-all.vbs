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

user = venv("USER")
if user = "" then user = "gcoakley"

homedrive = "C:"
homepath  = "\home\" & user
homeshare = "\\localhost\C$\Windows\CSC\v2.0.6\namespace\bpwfs01\home$\" & user

If interactive Then 
  Wscript.Echo "SETTING TO"
  Wscript.Echo "   homedrive = " & homedrive
  Wscript.Echo "    homepath = " & homepath
  Wscript.Echo "   homeshare = " & homeshare
  Wscript.Echo " userprofile = " & homedrive & homepath
  Wscript.Echo "     appdata = " & homedrive & homepath & "\AppData\Roaming"
  Wscript.Echo "localappdata = " & homedrive & homepath & "\AppData\Local"
End If 

If StrComp(venv("USERPROFILE"), "c:\home\gcoakley", vbTextCompare) = 0 Then
	Wscript.Quit(0)
End If

venv("HOMEDRIVE")	 = homedrive
venv("HOMEPATH") 	 = homepath
venv("HOME_SHARE")	 = homeshare
venv("HOMESHARE")	 = ""
venv("USERPROFILE")	 = homedrive & homepath
venv("APPDATA")		 = homedrive & homepath & "\AppData\Roaming"
venv("LOCALAPPDATA") = homedrive & homepath & "\AppData\Local"

rem Many paths under these registry keys should be changed.
rem HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
rem HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
rem C:\Users\gcoakley\AppData\Roaming\Microsoft\Windows\Libraries

If interactive Then Call showVolatile()

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
