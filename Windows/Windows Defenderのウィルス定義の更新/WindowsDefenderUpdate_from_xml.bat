@echo off
rem Windows Defender�̃E�B���X��`�̍X�V
setlocal

set XML_FILE=%~dp0WindowsDefenderUpdate.xml

schtasks /create /tn "Windows Defender�̃E�B���X��`�̍X�V" /xml "%XML_FILE%"

pause

endlocal