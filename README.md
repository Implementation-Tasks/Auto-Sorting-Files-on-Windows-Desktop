# Auto-Sorting-Files-on-Windows-Desktop
This Repo helps you auto sorting files on Windows Desktop by their extensions


Please note that this script should be run with administrative privileges to ensure it has the necessary permissions to move files around. Also, make sure to back up your files before running this script to prevent any accidental data loss.

This script works as follows:

It changes the current directory to the Desktop.
It loops over all files in the Desktop.
For each file, it gets the extension and stores it in the folder variable.
It checks if a folder with the name of the extension already exists. If not, it creates one.
It then moves the file into the folder with the same name as the file’s extension.
Please replace %USERPROFILE%\Desktop with the actual path of your Desktop if it’s different. Also, this script doesn’t handle files without extensions or with the same name but different extensions. You might want to handle these edge cases according to your needs.

Remember to save this script with a .bat or .cmd extension to run it. You can double-click the saved batch file to execute it.

Disclaimer: This script is provided as is, without warranty of any kind. Use of this script is at your own risk and responsibility. Always make sure to backup your data before running scripts that modify file systems.

**KEY IMPROVEMENTS:**

Enhanced File Type Handling:

Reads mappings from config.txt (format: .ext,FolderName).
Creates subfolders dynamically based on file types.
Improved User Experience:

Logs successful file movements.
Added a progress bar (using robocopy /tee).
Displays messages when files are skipped due to size limits.
Advanced Filtering and Sorting:

Uses robocopy to filter by file size (/minsize) while moving.
Includes date-based sorting by creating folders with the current date.
Uses robocopy to move and log the file operations.
Additional Features:

Placeholder comments for future implementation of scheduling, undo, and cloud sync.
How to Use:

Create config.txt: In the same directory as your batch script, create a config.txt file with lines like:

.txt,Documents
.jpg,Images
.mp3,Music
Set Size Limit: Add the size limit of the files in bytes (e.g., 10485760 for 10 MB) on the first line of config.txt.

Run the Script: Execute the batch script from the Command Prompt or PowerShell.

Remember:

Customize the config.txt file to match your desired file type mappings.
Fill in the implementations for scheduling, undo, and cloud sync if needed.
Thoroughly test the script before using it on your actual desktop.
