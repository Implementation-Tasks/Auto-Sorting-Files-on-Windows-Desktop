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
