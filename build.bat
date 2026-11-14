@echo off
REM CI build script for Windows Jenkins agents.
REM Jenkins job: Build Steps -> Execute Windows batch command -> call build.bat
echo === CI Build Started ===
echo Build number: %BUILD_NUMBER%

echo --- Tool versions ---
python --version
if errorlevel 1 (
    echo Python not found on this agent
    exit /b 1
)

echo --- Checking source files ---
dir /s /b src tests

echo --- Running application ---
python -m src.calculator
if errorlevel 1 (
    echo APPLICATION RUN FAILED
    exit /b 1
)

echo === Running Application Tests ===
python -m unittest discover -s tests -t . -v
if errorlevel 1 (
    echo TESTS FAILED
    exit /b 1
)

echo === CI Build Completed Successfully ===
exit /b 0
