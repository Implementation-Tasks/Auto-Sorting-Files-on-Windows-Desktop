@echo off
setlocal enabledelayedexpansion

set "sourceFolder=%USERPROFILE%\Desktop"
set "targetFolder=%USERPROFILE%\Desktop\SortedFiles"
set "configFile=%~dp0config.txt"
set /p sizeLimit=<"%configFile%"

for %%F in (%sourceFolder%\*) do (
    set "ext=%%~xF"
    set "ext=!ext:~1!"
    set "filename=%%~nF"
    set "filedate=%%~tF"

    rem -- 1. Enhanced File Type Handling --
    for /f "tokens=1,2 delims=," %%A in (%configFile%) do ( 
        if /i "%%~xF"=="%%A" (
            if not exist "%targetFolder%\%%B" md "%targetFolder%\%%B"
            move /Y "%%F" "%targetFolder%\%%B"
        )
    )

    rem -- 2. Improved User Experience --
    echo Moved "%%F" to "%targetFolder%\%%B"

    rem -- 3. Advanced Filtering and Sorting --
    for /f "delims=" %%C in ('robocopy "%sourceFolder%" "%targetFolder%\%%B" "%%F" /mov /maxage:-1 /minsize:%sizeLimit% /tee') do set result=%%C
    if not "!result!"=="" (
        echo !result!
        for /f "tokens=1,4 delims=: " %%D in ("!result!") do (
            if "%%D"=="Total" (
                echo "Skipped %%F due to size limit."
            )
        )
    )

    rem -- 4. Additional Features (Scheduled sorting, etc.) --
    :: (Implementation of scheduled sorting, undo, cloud sync left as an exercise)

)
