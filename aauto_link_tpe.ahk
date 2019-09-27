/*
Ver 1.0 - First version
Ver 1.1 - Add GUI and more Hotkey
Ver 1.2 - Add url and account setting text file
Ver 1.3 - Change to use ck101 account for vote
Ver 1.4 - Add Gold vote process
*/
;-------------------------------------------------------------
SoftVersion := "Ver 1.4"
ReadMeTxt := "使用說明:`n`n請先開啟chrome瀏覽器`n沒有先開啟程式會錯亂喔`n`nCtrl + q: 結束程式`nCtrl + r: 重新執行程式`nCtrl + e: 停止點擊"
IEsettingTitle := "網際網路 內容"
IEdelCookitTitle := "刪除瀏覽歷程記錄"
account_password := "10211021"
;黃金票張數
gold_vote_num :=3
;一個帳號可投票數
max_vote_num := 7

file_read_count := 0

;Create the array, for account
Account_Array := Object()
Account_ArrayCount := 0

;Create the array for all url
Url_Array := Object()
Url_ArrayCount := 0

;Create the array for remain vote
Remain_Array := Object()
Remain_ArrayCount := 0

;-----剩下要投的座標, 最多7票, 所以先設6組座標-----
;-----第一組座標-----
Remain_Array[1,1] := 1162
Remain_Array[1,2] := 1586
;-----第二組座標-----
Remain_Array[2,1] := 1320
Remain_Array[2,2] := 1584
;-----第三組座標-----
Remain_Array[3,1] := 1494
Remain_Array[3,2] := 1574
;-----第四組座標-----
Remain_Array[4,1] := 1664
Remain_Array[4,2] := 1574
;-----第五組座標-----
Remain_Array[5,1] := 1832
Remain_Array[5,2] := 1574
;-----第六組座標-----
Remain_Array[6,1] := 1990
Remain_Array[6,2] := 1574

;MsgBox 0,, % Remain_Array[6,2]
;----------------讀取所有帳號------------------------
Loop, read, account.txt
{
	Account_ArrayCount += 1
	Account_Array[Account_ArrayCount] := A_LoopReadLine
}

;----------------讀取所有需要點擊的url----------------------
Loop, read, url.txt
{
	file_read_count += 1
	if (file_read_count = 1)
	{
		account_main := A_LoopReadLine
	}
	else
	{
		URL_ArrayCount += 1
		URL_Array[URL_ArrayCount] := A_LoopReadLine
	}
}

url_total_num := file_read_count
if (url_total_num > max_vote_num)
{	
	MsgBox 0,錯誤,錯誤!`nurl.txt列表數量(%url_total_num%)超過可投票數(%max_vote_num%)
}

;計算剩下要投的人數
remain_vote_num := max_vote_num - url_total_num

;--------------------開始點擊-------------------------------
MsgBox 0,按下確定開始點擊,%ReadMeTxt%

;----獲得苦勞值----
Get_gold_vote(x, y)
{
	Sleep 1000
	Click %x%,%y%
	Sleep 7000
	;--拉到最底(重覆多按幾次end才會跑到正確的位置)--
	Send {end}	
	Sleep 2000
	Send {end}
	Sleep 2000
	Send {end}
	Sleep 2000
	;--點擊領取苦勞值--
	Click 1416,1586
	;--關閉分頁--
	Sleep 2000
	Send ^w
	Sleep 1000
}

Account_ArrayCount := 1
While Account_Array[Account_ArrayCount] != ""
{
	Sleep 1000

	;--把chrome設為activate程式--
	winactivate, ahk_exe chrome.exe
	Sleep 1000

	;--ctrl + shift + n 開啟無痕視窗--
	send, ^+n
	Sleep 2000

	;--貼上網址並按下enter--
	send, ^l
	;clipboard = % Link_url
	clipboard = % account_main
	send, ^v
	send, {Enter}
	Sleep 4000

	;--按下投票 (座標根據螢幕解析度不同, 要自己改喔)--
	;Click 1410,1203 ;frww
	Click 1410,1203 ;william
	Sleep 4000

	;--輸入帳號--
	Click 1628,636 ;william
	clipboard = % Account_Array[Account_ArrayCount]
	send, ^v
	send, {Enter}
	Sleep 300

	;--輸入密碼--
	Click 1611,794 ;william
	clipboard = %account_password%
	send, ^v
	send, {Enter}
	Sleep 4000
	
	;--點擊卡提諾準被獲得苦勞值--
	Click 207,252 ;william
	Sleep 11000
	
	;--點擊關閉廣告--		
	Click 2931,1795 ;william
	
	;--點3個文章獲取苦勞值--
	Get_gold_vote(966,1461)
	Get_gold_vote(1279,1488)
	Get_gold_vote(1636,1501)
	Sleep 1000
	
	;--關閉卡提諾首頁分頁, 回到投票頁--	
	Send ^w
	Sleep 2000
	
	;--按下投票--
	;Click 1410,1203 ;frww
	Click 1410,1203 ;william
	Sleep 2000
	
	;--投url.txt的指定帳號--
	URL_ArrayCount := 1
	While URL_Array[URL_ArrayCount] != ""
	{
		;--貼上網址並按下enter--
		send, ^l
		clipboard = % URL_Array[URL_ArrayCount]
		send, ^v
		send, {Enter}
		Sleep 4000
		
		;--按下投票--
		;Click 1410,1203 ;frww
		Click 1410,1203 ;william
		Sleep 2000
		
		URL_ArrayCount += 1
	}
	
	;--投剩下的票 (7票要投完)--
	Remain_ArrayCount := 1
	Loop, %remain_vote_num%
	{
		remain_x := % Remain_Array[Remain_ArrayCount, 1]
		remain_y := % Remain_Array[Remain_ArrayCount, 2]
		Click %remain_x%, %remain_y%
		Sleep 1000
		
		;--按下投票--
		;Click 1410,1203 ;frww
		Click 1410,1203 ;william
		Sleep 2000
		
		Remain_ArrayCount += 1
	}

	;--換黃金票---
	;--點擊閱換黃金票--
	Sleep 1000
	Click 3486,2044
	Sleep 3000
	;--點擊確認閱換--
	Click 3051, 995
	Sleep 3000
	
	;--黃金票點擊主帳號--
	send, ^l
	clipboard = % account_main
	send, ^v
	send, {Enter}
	Sleep 4000
	;--按下投票, 投3次--
	Loop, %gold_vote_num%
	{
		;Click 1410,1203 ;frww
		Click 1410,1203 ;william
		Sleep 2000
	}
	
	;--關閉無痕視窗--
	send, !{f4}
	Sleep 3000

	Account_ArrayCount += 1
}

return

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
	



