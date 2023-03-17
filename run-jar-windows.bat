:: Batch script
:: Save this file as run-jar-windows.bat
:: Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]
@echo off

echo ""
echo "run-jar-windows.bat %1 %2 %3 %4">>log-jar.txt

if "%1" == "" (
  echo "[ERROR] No arguments given. Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]"
  exit /b 1
)

if not "%4" == "" (
  echo "[ERROR] Too many arguments. Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]"
  exit /b 1
)

if "%2" == "" (
  if not exist "%1" (
      echo "[ERROR] Jar file %1 does not exist. Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]"
      exit /b 1
  )
  if exist %1\ (
      echo "[ERROR] Jar file %1 does not exist. Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]"
      exit /b 1
  )
)

if not "%2" == "" (
  if not "%1" =="--decompile-dir" (
    if not "%2" =="--decompile-dir" (
      echo "[ERROR] Invalid arguments. Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]"
      exit /b 1
    )
    if not exist "%1" (
      echo "[ERROR] Jar file %1 does not exist. Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]"
      exit /b 1
    )
    if exist %1\ (
      echo "[ERROR] Jar file %1 does not exist. Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]"
      exit /b 1
    )
  ) else (
      if not exist "%3" (
        echo "[ERROR] Jar file %2 does not exist. Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]"
        exit /b 1
      )
      if exist %3\ (
        echo "[ERROR] Jar file %2 does not exist. Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]"
        exit /b 1
      )
  )
)


:: ignore circumstances in which command has error but exit code is 0
csa.exe score-models import --over-write-models >> log-jar.txt 2>>&1
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%%, please send the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)

csa.exe rules delete-all >> log-jar.txt 2>>&1
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%%, please send the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)

csa.exe rules import >> log-jar.txt 2>>&1
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%%, please send the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)

csa.exe %1 %2 %3 -a 2>>log-jar.txt
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%, please validate the arguments given, Usage: run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]. You can also end the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)

csa.exe ui 2>>log-jar.txt
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%%, please send the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)