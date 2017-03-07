:: Reset errorlevel status so we are not inheriting this state from the calling process:
@call :CLEAN_EXIT

:: Set the blast root to the current directory so that included solutions that aren't Blast know where the root is without having to
:: guess or hardcode a relative path.
:: Use the "short" path so that we don't have to quote paths in that calls below. If we don't do that spaces can break us.
@SET OPENVDB_ROOT_DIR=%~sdp0

:: Run packman to ensure dependencies are present and run cmake generation script afterwards
@echo Running packman in preparation for cmake ...
@echo.
@call "%~dp0buildtools\packman\windows\packman.cmd" %PM_OPTIONS_EXT% pull "%~dp0dependencies.xml" --platform win --postscript "%~dp0buildtools\cmake_projects_vc14win64.bat"
@if %ERRORLEVEL% neq 0 (
    @exit /b %errorlevel%
) else (
    @echo Success!
)


	  
:CLEAN_EXIT
@exit /b 0
