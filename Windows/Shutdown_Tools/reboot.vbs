Option Explicit

Dim Ans
Dim strCmdLine
Dim objShell

Set objShell = WScript.CreateObject("WScript.Shell")
strCmdLine = "shutdown /r /t 0"

Ans = MsgBox("�ċN�����܂����H�H", vbYesNo, "�ċN���m�F")
If Ans = vbYes Then
   objShell.Exec(strCmdLine)  
Else

End If