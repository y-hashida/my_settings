Option Explicit

Dim Ans
Dim strCmdLine
Dim objShell

Set objShell = WScript.CreateObject("WScript.Shell")
strCmdLine = "shutdown /s /t 0"

Ans = MsgBox("�V���b�g�_�E�����܂����H�H", vbYesNo, "�V���b�g�_�E���m�F")
If Ans = vbYes Then
   objShell.Exec(strCmdLine)  
Else

End If