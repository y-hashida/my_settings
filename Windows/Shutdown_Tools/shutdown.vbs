Option Explicit

Dim Ans
Dim strCmdLine
Dim objShell

Set objShell = WScript.CreateObject("WScript.Shell")
strCmdLine = "shutdown /s /t 0"

Ans = MsgBox("シャットダウンしますか？？", vbYesNo, "シャットダウン確認")
If Ans = vbYes Then
   objShell.Exec(strCmdLine)  
Else

End If