Option Explicit

Dim Ans
Dim strCmdLine
Dim objShell

Set objShell = WScript.CreateObject("WScript.Shell")
strCmdLine = "shutdown /r /t 0"

Ans = MsgBox("再起動しますか？？", vbYesNo, "再起動確認")
If Ans = vbYes Then
   objShell.Exec(strCmdLine)  
Else

End If