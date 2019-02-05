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

homedrive = "Z:"
homepath = "\"
homeshare = "\\bpwfs01\home$\GCoakley"
' Is synchronized to: 
' \\localhost\C$\Windows\CSC\v2.0.6\namespace\bpwfs01\home$\gcoakley

If interactive Then 
  Wscript.Echo "SETTING TO"
  Wscript.Echo "  homedrive = " & homedrive
  Wscript.Echo "  homepath  = " & homepath
  Wscript.Echo "  homeshare = " & homeshare
End If  
venv("HOMEDRIVE") = homedrive
venv("HOMEPATH")  = homepath
venv("HOMESHARE") = homeshare
venv("USERPROFILE") = "C:\Users\gcoakley"

If interactive Then Call showVolatile()

Wscript.Quit(0)


Sub showVolatile()
  Wscript.Echo "VOLATILE ENVIRONMENT settings in registry"
  Wscript.Echo "  USERPROFILE = " & venv("USERPROFILE")  
  Wscript.Echo "  HOMEDRIVE = " & venv("HOMEDRIVE")  
  Wscript.Echo "  HOMEPATH = " & venv("HOMEPATH")  
  Wscript.Echo "  HOMESHARE = " & venv("HOMESHARE")  
End Sub