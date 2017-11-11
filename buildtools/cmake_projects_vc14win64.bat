@echo off

echo #############################################################################################
echo Starting %~n0 %date% %time%
echo #############################################################################################

echo PM_CMakeModules_VERSION %PM_CMakeModules_VERSION%

if NOT DEFINED PM_CMake_VERSION GOTO DONT_RUN_STEP_2

IF NOT DEFINED PM_PACKAGES_ROOT GOTO PM_PACKAGES_ROOT_UNDEFINED

REM Now set up the CMake command from PM_PACKAGES_ROOT

SET CMAKECMD=%PM_cmake_PATH%\bin\cmake.exe

echo "Cmake: %CMAKECMD%"

REM Set these root paths from the Packman env variables.
set BOOST_ROOT=%PM_boost_PATH%
set BOOST_LIBRARYDIR=%PM_boost_PATH%/lib64-msvc-14.0
set GLEW_ROOT=%PM_glew_PATH%
set GLFW3_ROOT=%PM_glfw_PATH%
set ILMBASE_ROOT=%PM_OpenEXR_PATH%
set OPENEXR_ROOT=%PM_OpenEXR_PATH%
set TBB_ROOT=%PM_IntelTBB_PATH%
set BLOSC_ROOT=%PM_c_blosc_PATH%
set ZLIB_ROOT=%PM_zlib_PATH%
set ZLIB_BINARY_ROOT=%PM_zlib_PATH%/contrib/vstudio/vc14/

REM Generate projects here

echo "Blosc Root %BLOSC_ROOT%"

echo.
echo #############################################################################################
ECHO "Creating VS2015 Win64"

SET CMAKE_OUTPUT_DIR=compiler\vc14win64-cmake\
IF EXIST %CMAKE_OUTPUT_DIR% rmdir /S /Q %CMAKE_OUTPUT_DIR%
mkdir %CMAKE_OUTPUT_DIR%
pushd %CMAKE_OUTPUT_DIR%

%CMAKECMD% %OPENVDB_ROOT_DIR%\openvdb ^
	-D TARGET_BUILD_PLATFORM=Windows ^
	-D DOXYGEN_SKIP_DOT=ON ^
	-D Blosc_USE_STATIC_LIBS=OFF ^
	-D USE_GLFW3=ON ^
	-D GLFW3_USE_STATIC_LIBS=ON ^
	-D Boost_USE_STATIC_LIBS=ON ^
	-D Boost_INCLUDE_DIR=%BOOST_ROOT% ^
	-D ZLIB_INCLUDE_DIR=%ZLIB_ROOT% ^
	-D ZLIB_LIBRARY=%ZLIB_BINARY_ROOT%/x64/ZlibStatRelease/zlibstat.lib ^
	-D TBB_LIBRARY_DIR=%TBB_ROOT%/lib/intel64/vc14 ^
	-D TBB_LIBRARY_PATH=%TBB_ROOT%/lib/intel64/vc14 ^
	-D Tbb_TBB_LIBRARY=%TBB_ROOT%/lib/intel64/vc14/tbb.lib ^
	-D Tbb_TBBMALLOC_LIBRARY=%TBB_ROOT%/lib/intel64/vc14/tbbmalloc.lib ^
	-D Tbb_TBB_PREVIEW_LIBRARY=%TBB_ROOT%/lib/intel64/vc14/tbb_preview.lib ^
	-D ILMBASE_ROOT=%ILMBASE_ROOT% ^
	-D CMAKE_INSTALL_PREFIX=%OPENVDB_ROOT_DIR%/built/ ^
	-D STATIC_WINCRT=ON ^
	-D OPENVDB_ENABLE_3_ABI_COMPATIBLE=OFF ^
	-D OPENVDB_BUILD_SHARED=ON ^
	-D CMAKE_PREFIX_PATH=%PM_PATHS% ^
	-G "Visual Studio 14 2015" ^
	-Ax64 ^
	%OPENVDB_ROOT_DIR%
popd
if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%


GOTO :End

:PM_PACKAGES_ROOT_UNDEFINED
ECHO PM_PACKAGES_ROOT has to be defined, pointing to the root of the dependency tree.
PAUSE
GOTO END

:DONT_RUN_STEP_2
ECHO Don't run this batch file directly. Run generate_projects_(platform).bat instead
PAUSE
GOTO END

:End
