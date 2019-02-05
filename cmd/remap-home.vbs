Set shell = WScript.CreateObject("WScript.Shell")  
Set venv = shell.Environment("Volatile")  

scriptingHost = LCase(Right(Wscript.FullName,Len("cscript.exe")))
interactive = Wscript.Interactive And (scriptingHost = "cscript.exe")

If interactive Then 
  Wscript.Echo "  ScriptFullName = " & Wscript.ScriptFullName
  
  Call showVolatile("before changes.")
End If

If InStr(1, LCase(venv("USERPROFILE")), "c:\home\gcoakley") = 1 Then
	venv("USERPROFILE") = "c:\home\gcoakley"
End If

If InStr(1, LCase(venv("APPDATA")), "c:\home\gcoakley") = 1 Then
	venv("APPDATA") = "c:\home\gcoakley" & "\AppData\Roaming"
	venv("LOCALAPPDATA") = "c:\home\gcoakley" & "\AppData\Local"
End If


If interactive Then Call showVolatile("after changes.")
Wscript.Quit(0)


Sub showVolatile(tag)
  Wscript.Echo "  Registry settings " & tag
  Wscript.Echo "    USERPROFILE = "  & venv("USERPROFILE")  
  Wscript.Echo "    APPDATA = " 		& venv("APPDATA")  
  Wscript.Echo "    LOCALAPPDATA = " & venv("LOCALAPPDATA")  
End Sub
