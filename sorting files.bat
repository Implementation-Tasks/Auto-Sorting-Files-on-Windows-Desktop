@echo off
cd %USERPROFILE%\Desktop
for /r %%i in (*) do (
    set "folder=%%~xi"
    setlocal enabledelayedexpansion
    if not exist "!folder:~1!" (
        mkdir "!folder:~1!"
    )
    move "%%i" "!folder:~1!"
    endlocal
)
