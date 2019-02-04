
#NoEnv 		; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input 	; Recommended for new scripts due to its superior speed and reliability.

;''
;'' Swap both pairs of Alt and Ctrl keys.
;''
#UseHook On	; Turns off warning for MaxHotkeysPerInterval for the following definitions. 
;'' Either of these methods below work. The first operates slower than the second and both have 
;'' issues with flooding events into IntelliJ which causes missed modifier key down detection.
;Ctrl::Alt
;Alt::Ctrl
;'' But, this does. Although, IntelliJ does lose the LeftAlt key at times.
;RAlt::LCtrl
;RCtrl::LAlt
;LAlt::RCtrl
;LCtrl::RAlt
;UseHook Off

#Include C:\dev\config\GAC-util.ahk

; #Include C:\dev\config\DockWin-GAC.ahk

;'' Hotkeys / Shortcuts
;''
;'' modifiers: ^= Control, != Alt, += Shift, #= Windows
;'' Use 'return' on its own line to end a multiline shortcut script.

;'' IntelliJ, Chrome, HipChat etc. have redraw issues at times (often caused by Outlook).
;'' This will change the current window geometry by 0-1 pixels, causing a redraw thus correcting the display issue.
^#z::
   WinGetActiveTitle, wintitle
   WinGetPos, winx, winy, width, height, %wintitle%
   Random, randwidth, -1, 1
   Random, randheight, -1, 1
   WinMove, %wintitle%,, winx, winy, (width + randwidth), (height + randheight)
return
^!+/::
   ; Lines read from files are trimmed by default. See 'AutoTrim'.
   FileRead, encoded, C:\Users\GCoakley\Documents\wnlo_p.txt
   decoded := Base64Decode(encoded)
   SendInput %decoded%
   SendInput {enter}
return

;''
;'' Text Expansions / functions
;''
;'' options: https://autohotkey.com/docs/Hotstrings.htm#Asterisk
;''
::;an_multiline_hotstring_example::
(
This is a multi-line snippet. This is inserted when the following is typed then tab,enter,space is pressed. 
	;an_multiline_hotstring_example
)
:*:backend::back-end
:*:frontend::front-end
:c*:drcc::datarecognitioncorp.com
:c*:gcdrc::gcoakley@datarecognitioncorp.com
:c*:ghdr::https://github.com/DataRecognitionCorporation/
:c*:Gda::Good afternoon
:c*:Gdd::Good day
:c*:Gdm::Good morning
:c*:Gdn::Good night
:c:jsc::javascript
:*:[now]::  ; This hotstring replaces "[now]" with the current date and time via the commands below.
   FormatTime, CurrentDateTime,, MMM/d/yyyy h:mm tt  ; It will look like 9/1/2005 3:53 PM
   SendInput %CurrentDateTime%
return

:c:BE::back-end
:c:FE::front-end
:c:huh?::Can you clarify what you mean?
::Np::No problem.
::Yw::You are welcome.


;'' Hipchat Crispy STRONG (arms)
::(kfcstrong)::(bicepleft) (kfcolonel) (bicepright)

;'' Mongo snippets.  The syntax {{} will output a single left-curly-brace, {}} a right one.
::dbq10k::DBQuery.shellBatchSize = 10000;
;'' The syntax {{} will output a single left-curly-brace, {}} a right one.
:*:forE::forEach(function(it){{}  {}});{left 4}

;'' Convert IDs per line to IDs CSV. (Notepad++ etc.)
::l2c::^(\d+)\s*${TAB}"\1",
::myhang::https://hangouts.google.com/hangouts/_/datarecognitioncorp.com/glen
::[nbsp]:: 


:c:A1::A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 1 2 3 4 5 6 7 8 9 0
