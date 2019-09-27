;Ver 1.0 - First version

; Create the array, initially empty
Setting_Count := 0
DialName := ""
ConnectName := ""
ConnectPass := ""
Link_Array := Object()
Link_ArrayCount := 0

;-------------------------------------------------------------
Loop, read, Setting.txt
{
	Setting_Count += 1
	if (Setting_Count <= 3)
	{
		if (Setting_Count = 1)
		{
			DialName := A_LoopReadLine
		}
		else if (Setting_Count = 2)
		{
			ConnectName := A_LoopReadLine
		}
		else
		{
			ConnectPass := A_LoopReadLine
		}
	}
	else
	{
		Link_ArrayCount += 1
		Link_Array[Link_ArrayCount] := A_LoopReadLine
	}

}

;---------------------------------------------------------------


^p::
Loop
{
	Link_ArrayCount := 1
	While Link_Array[Link_ArrayCount] != ""
	{
		Sleep 1000
		Run % Link_Array[Link_ArrayCount]
		winactivate, ahk_class IEFrame
		StatusBarWait, 完成, 30, 1, ahk_class IEFramep
		sleep, 1000
		Send {enter}
		winactivate, ahk_class IEFrame
		StatusBarWait, 完成, 30, 1, ahk_class IEFrame
		Sleep 2000
		Send {F5}
		sleep, 1000
		Send {enter}
		Sleep 2000
		Send !{F4}
		Sleep, 2000
		
		Link_ArrayCount += 1
	}
	;-------------------------------------------------------------------------------------


	DeleteAll()	
						
	Run rasdial %DialName% /disconnect
	sleep, 500
	Loop
	{	
	IfWinNotExist C:\WINDOWS\system32\rasdial.exe
		break
	}				
	Sleep, 8000	
			
	Run rasdial %DialName% %ConnectName% %ConnectPass%
	sleep, 500
	Loop
	{	
	IfWinNotExist C:\WINDOWS\system32\rasdial.exe
		break						
	}

	Sleep 2000

}
	return
;-------------------------------------------------------------

DeleteAll()
{
	run, inetcpl.cpl
	winwait, 網際網路 內容,
	winactivate, 網際網路 內容,

	sleep, 200 
	send, !d  
	winwait, 刪除瀏覽歷程記錄, 
	winactivate, 刪除瀏覽歷程記錄, 
	send, !d  
	sleep,200  
	
	;send, !f  
	;winwait, 刪除檔案, 
	;winactivate, 刪除檔案, 
	;send, {Space}
	;Sleep 200
	;Send, {Enter} 
	;Sleep 200

	;send, !h 
	;winwait, 網際網路選項, 
	;winactivate, 網際網路選項, 
	;send, {Tab}
	;Sleep 200
	;Send, {Enter} 
	;Sleep 200

	winwaitactive, 網際網路 內容, 
	send, !{F4}  
}




;-----------------------------------------------------------------
;^!n::
;	IfWinExist Untitled - Notepad
;		WinActivate
;	else
;		Run Notepad
;	return
;---------------------------------------------------------------
^r::
	reload
	return
^q::
	ExitApp
^t::
	MsgBox Ver 1.0
	



