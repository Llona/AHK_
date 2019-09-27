NetworkInterface := "PPP �����d cci:"
InCorrectNetworkInterface := false
IPaddressTag := "IPv4 ��}"
IPaddress := ""
HtmlIPString := ""

Run, %comspec% /c ipconfig > ip.txt
;Run, %comspec% /c dir /b > C:\list.txt && type C:\list.txt && pause


;---------------------------------------------------------------------------------------------------------------------

Loop, read, ip.txt
{
	;IfEqual, InCorrectNetworkInterface, %false%
	If InCorrectNetworkInterface = %false%
	{
		;MsgBox % A_LoopReadLine
		IfEqual, A_LoopReadLine, %NetworkInterface%
		{
			;Is in CCI network interface, set flag to true then goto next read file loop
			;MsgBox into first loop
			InCorrectNetworkInterface := true
			continue
		}
		else
		{
			;Not in CCI network interface, goto next read file loop
			;MsgBox into first loop else
			continue
		}
	}
	else
	{
		;Flag is true, in CCI network interface line, read IPV4 address
		;MsgBox % A_LoopReadLine
		IfInString, A_LoopReadLine , %IPaddressTag%
		{
			;Is IPV4 line, read IP address
			;MsgBox find IPV4
			RegExMatch(A_LoopReadLine, IPaddressTag " . . . . . . . . . . . . : (.*)" , SubPat)
			IPaddress := SubPat1
			MsgBox % IPaddress "`n"
			break	
		}
		else
		{
			;not IPV4 line, goto next read file loop
			;MsgBox no ipv4
			continue
		}
	}
	
}
file := FileOpen("C:\miniweb\htdocs\index.html", "w")
if !IsObject(file)
{
	MsgBox Can't open "%FileName%" for writing.
	return
}
HtmlIPString := IPaddress  ; When writing a file this way, use `r`n rather than `n to start a new line.
file.Write(HtmlIPString)
file.Close()





;ExitApp

^r::
	reload
	return
^q::
	ExitApp

