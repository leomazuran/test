@echo off
echo Checking Registry.
REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat /v cadca5fe-87d3-4b96-b7fb-a231484277cc
IF %errorlevel%==1 GOTO INSTALL
echo The information has already been added to the Registry.
pause
exit
:INSTALL
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Requesting UAC...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
CD /D "%~dp0"
echo Adding info to Registry
reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat /f /v cadca5fe-87d3-4b96-b7fb-a231484277cc /t REG_DWORD /d 0
echo Checking
ping -n 3 127.0.0.1 > nul
cls
echo added following info to Registry
REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat /v cadca5fe-87d3-4b96-b7fb-a231484277cc
IF %errorlevel%==1 GOTO ERROR
echo Process Complete!
echo Check Windows for updates.
pause
exit
:ERROR
echo ERROR!!! Something went wrong.
pause
:---Writen by Leonardo Mazuran-------
:---leonardo@carvir.net----

