@echo off
rem 2020-11-18 Sukri Created.

rem script name.
set "script_name=Install-MSIApplication.ps1"

rem script directory.
set "script_directory=%~dp0"

rem execute PS1 script.
PowerShell -ExecutionPolicy bypass -file "%script_directory%%script_name%"

rem pause, press any key to exit.
pause