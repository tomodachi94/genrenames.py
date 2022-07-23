@echo off
setlocal EnableDelayedExpansion

@echo This script outputs all images from a mod with an underscore in the name to rename.txt in that folder.
set /P name="What is the mod abbreviation? "
@echo.
@echo.
if not exist %name% (
    @echo A folder with the name "%name%" does not exist, please run this script again.
    @echo.
    PAUSE
    goto :EOF
)
cd %name%
if exist renames.txt (
    @echo Moving old renames.txt to renames_old.txt
    move /-Y renames.txt renames_old.txt
)
set /P doall="Would you like to output ALL files to be renamed? y/n    "
for /r %%a in (*.png) do (
    set testvar=%%~na
    if "%doall%" == "y" (
        @echo !testvar!=>>renames.txt
    ) else (
        set next=!testvar:_=!
        if not !next!==!testvar! @echo !testvar!=>>renames.txt
    )
)
if exist renames.txt (
    @echo Output to %name%/renames.txt
    explorer renames.txt
) else (
    @echo No image file was found with an underscore in the name.
)
@echo.
PAUSE