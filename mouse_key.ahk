SoftVersion := "0.0.1"

;~Esc::
~XButton1::
	Keywait, XButton1, , t0.5
	if errorlevel = 1
		return
	else
		Keywait, XButton1, d, t0.1
	if errorlevel = 0
	{
		WinGetActiveTitle, Title
		WinClose, %Title%
		return
	}
	return

;^r::
	reload
	return
;^q::
;	ExitApp
;^e::
;	Exit
;^t::
;	MsgBox, 0, 版本, 目前版本為: %SoftVersion%