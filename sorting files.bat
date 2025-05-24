@echo off
setlocal enableDelayedExpansion

:: --- Operation Options ---
:: Set to "MOVE" to move files (delete from source)
:: Set to "COPY" to copy files (keep in source)
set "OPERATION=MOVE" 

:: --- Logging Options ---
:: Set to "YES" to enable logging
:: Set to "NO" to disable logging
set "ENABLE_LOG=YES"

echo.
echo ===================================================
echo   AUTOMATIC FILE SORTING SCRIPT
echo   Version: 1.0
echo ===================================================
echo.

:GET_SOURCE_DIR
set "SOURCE_DIR="
set /p "SOURCE_DIR=Type your source folder (E.g: D:\Documents): "
if not defined SOURCE_DIR (
    echo.
    echo Error: Source folder path cannot be empty.
    goto :GET_SOURCE_DIR
)
if not exist "%SOURCE_DIR%" (
    echo.
    echo Error: Source folder "%SOURCE_DIR%" not found. Please check again.
    goto :GET_SOURCE_DIR
)
echo.

:GET_DEST_DIR
set "DEST_DIR="
set /p "DEST_DIR=Type your target folder (E.g: D:\SortedFiles): "
if not defined DEST_DIR (
    echo.
    echo Error: Target folder path cannot be empty.
    goto :GET_DEST_DIR
)
:: Create target folder if it doesn't exist
if not exist "%DEST_DIR%" (
    echo.
    echo Target folder "%DEST_DIR%" not found. Creating...
    mkdir "%DEST_DIR%"
    if not exist "%DEST_DIR%" (
        echo Error: Could not create target folder "%DEST_DIR%". Please check permissions.
        goto :GET_DEST_DIR
    ) else (
        echo Target folder created successfully.
    )
)
echo.

:: --- Initialize counters and log ---
set /a files_processed = 0
set /a errors_encountered = 0

if /i "%ENABLE_LOG%"=="YES" (
    set "LOG_FILE=%DEST_DIR%\file_sort_log_%DATE:~-4,4%%DATE:~-7,2%%DATE:~-10,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.log"
    echo --- File Sorting Started - %DATE% %TIME% --- > "%LOG_FILE%"
    echo Source: "%SOURCE_DIR%" >> "%LOG_FILE%"
    echo Target: "%DEST_DIR%" >> "%LOG_FILE%"
    echo Operation: %OPERATION% >> "%LOG_FILE%"
    echo. >> "%LOG_FILE%"
)

echo.
echo Starting file sorting from "%SOURCE_DIR%" to "%DEST_DIR%"...
echo Operation: %OPERATION%
echo.

:: --- Iterate through each file in the source folder ---
for %%f in ("%SOURCE_DIR%\*.*") do (
    if not "%%~xf" == "" (
        set "extension=%%~xf"
        :: Remove dot and convert to lowercase for folder name
        set "folder_name=!extension:.~=!"
        set "folder_name=!folder_name:.=!"
        set "folder_name=!folder_name: =_!" :: Replace spaces with underscores if any
        set "folder_name=!folder_name!"
        for %%a in ("!folder_name!") do set "folder_name=%%a"

        set "target_folder=%DEST_DIR%\!folder_name!"

        :: Create target folder if it doesn't exist
        if not exist "!target_folder!" (
            mkdir "!target_folder!"
            if not exist "!target_folder!" (
                echo Error: Could not create folder "!target_folder!".
                if /i "%ENABLE_LOG%"=="YES" (echo Error: Could not create folder "!target_folder!". >> "%LOG_FILE%")
                set /a errors_encountered += 1
                continue
            ) else (
                echo Created folder: "!target_folder!"
                if /i "%ENABLE_LOG%"=="YES" (echo Created folder: "!target_folder!" >> "%LOG_FILE%")
            )
        )

        set "fileName=%%~nf"
        set "fileExt=%%~xf"

        set "destPath=!target_folder!"

        :: --- Move or copy file to the corresponding target folder ---
        if /i "%OPERATION%"=="MOVE" (
            set "moved=false"
            move "%%f" "!destPath!" >nul 2>&1
            if not errorlevel 1 (
                set "moved=true"
                echo Moved: "%%f" -> "!destPath!"
                if /i "%ENABLE_LOG%"=="YES" (echo Moved: "%%f" -> "!destPath!" >> "%LOG_FILE%")
            ) else (
                echo Error moving file: "%%f"
                if /i "%ENABLE_LOG%"=="YES" (echo Error moving file: "%%f" >> "%LOG_FILE%")
                set /a errors_encountered += 1
            )

            if not exist "!destPath!\!fileName!!fileExt!" (
                echo   -> Moved "%%F" to "!destPath!"
                echo Debug: target_folder = !target_folder!
                echo Debug: destPath = !destPath!
                set "moved=true"
            ) else (
                echo   -> Could not move "%%F" to "!destPath!"
                set /a errors_encountered += 1
            )
        ) else (
            copy "%%f" "!destPath!" >nul 2>&1
            if not errorlevel 1 (
                echo Copied: "%%f" -> "!destPath!"
                if /i "%ENABLE_LOG%"=="YES" (echo Copied: "%%f" -> "!destPath!" >> "%LOG_FILE%")
            ) else (
                echo Error copying file: "%%f"
                if /i "%ENABLE_LOG%"=="YES" (echo Error copying file: "%%f" >> "%LOG_FILE%")
                set /a errors_encountered += 1
            )
        )

        set /a files_processed += 1
    )
)

echo.
echo Completed! Processed %files_processed% files.
if %errors_encountered% gtr 0 (
    echo Encountered %errors_encountered% errors during processing.
) else (
    echo No errors occurred.
)

if /i "%ENABLE_LOG%"=="YES" (
    echo.
    echo --- File Sorting Finished - %DATE% %TIME% --- >> "%LOG_FILE%"
    echo Total files processed: %files_processed% >> "%LOG_FILE%"
    echo Total errors: %errors_encountered% >> "%LOG_FILE%"
)

endlocal
pause
