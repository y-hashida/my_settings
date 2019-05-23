@echo off
rem Windows Defenderのウィルス定義の更新
setlocal

set XML_FILE=%~dp0WindowsDefenderUpdate.xml

schtasks /create /tn "Windows Defenderのウィルス定義の更新" /xml "%XML_FILE%"

pause

endlocal