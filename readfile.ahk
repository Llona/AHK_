; Create the array, initially empty
Setting_Count := 0
DialName := ""
ConnectName := ""
ConnectPass := ""
Link_Array := Object()
Link_ArrayCount := 0

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
;aa := Link_Array[2]
;MsgBox % DialName
;MsgBox % ConnectName
;MsgBox % ConnectPass
;MsgBox % Link_Array[2]
;MsgBox, %aa%