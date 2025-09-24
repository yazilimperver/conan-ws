@echo off
setlocal

REM ===== VS2022 Ortam Ayarlar?n? Yükle =====
call "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"

echo === Conan Install ===
conan install . --build=missing -pr=windows-msvc-vs2022-release -r=local-repo
if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

echo === CMake Configure ===
cmake --preset=conan-release
if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

echo === CMake Build ===
cmake --build build/Release
if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

echo === CTest Run ===
.\build\Release\test_app.exe
if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%

endlocal
pause
