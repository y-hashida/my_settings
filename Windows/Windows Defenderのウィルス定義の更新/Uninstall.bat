@echo off
rem Windows Defenderのウィルス定義の更新
setlocal

schtasks /delete /tn "Windows Defenderのウィルス定義の更新"

pause

endlocal