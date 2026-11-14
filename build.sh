#!/bin/sh
# CI build script for macOS/Linux Jenkins agents.
# Jenkins job: Build Steps -> Execute shell -> sh ./build.sh
# Exits non-zero (which fails the Jenkins build) if any test fails.

echo "=== CI Build Started ==="
echo "Build number: ${BUILD_NUMBER:-local}"
echo "Commit: ${GIT_COMMIT:-unknown}"

echo "--- Tool versions ---"
python3 --version || { echo "Python 3 not found on this agent"; exit 1; }

echo "--- Checking source files ---"
ls -R src tests

echo "--- Syntax check ---"
python3 -m py_compile src/calculator.py tests/test_calculator.py || { echo "SYNTAX CHECK FAILED"; exit 1; }

echo "--- Running application ---"
python3 -m src.calculator || { echo "APPLICATION RUN FAILED"; exit 1; }

echo "=== Running Application Tests ==="
if ! python3 -m unittest discover -s tests -t . -v; then
    echo "TESTS FAILED"
    exit 1
fi

echo "=== CI Build Completed Successfully ==="
exit 0
