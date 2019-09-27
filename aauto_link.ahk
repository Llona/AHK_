/*
Ver 1.0 - First version
Ver 1.1 - Add GUI and more Hotkey
*/
;-------------------------------------------------------------
SoftVersion := "Ver 1.1"
ReadMeTxt := "使用說明:`nCtrl + q: 結束程式`nCtrl + r: 重新執行程式`nCtrl + e: 停止點擊"
;IEsettingTitle := "網際網路 內容"
;IEdelCookitTitle := "刪除瀏覽歷程記錄"
IEsettingTitle := "網際網路 內容"
IEdelCookitTitle := "刪除瀏覽歷程記錄"
Setting_Count := 0
DialName := ""
ConnectName := ""
ConnectPass := ""
; Create the array, initially empty
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

MsgBox 0,按下確定開始點擊,%ReadMeTxt%

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


	DeleteCookie()	
						
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
/*
This function will delete all cookie and template browser file by windows IE setting UI
Should check IE delete cookie environment first
*/
DeleteCookie()
{
	run, inetcpl.cpl
	winwait, %IEsettingTitle%,
	winactivate, %IEsettingTitle%,

	sleep, 200 
	send, !d  
	winwait, %IEdelCookitTitle%, 
	winactivate, %IEdelCookitTitle%, 
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

	winwaitactive, %IEsettingTitle%, 
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
^e::
	Exit
^t::
	MsgBox 0,版本,%SoftVersion%
	



