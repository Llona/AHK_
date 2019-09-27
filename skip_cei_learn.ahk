SoftVersion := "0.0.1"
title_need_close := "警告"

Loop
{
	if WinActive("ahk_class IEFrame")
	{
		;WinMaximize  ; Maximizes the Notepad window found by IfWinActive above.
		WinGetActiveTitle, Title
		;MsgBox, The active window is "%Title%".
		IfInString, Title, %title_need_close%
		{
			Send {TAB}
			sleep 300
			Send {Space}
			;MsgBox, Into "%Title%".

		}
		sleep 1000
	}
	
}

^r::
	reload
	return
^q::
	ExitApp
^e::
	Exit
^t::
	MsgBox, 0, 版本, 目前版本為: %SoftVersion%