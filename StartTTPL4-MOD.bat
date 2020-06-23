@echo off
setlocal

SET MYSCRIPT=%0
Rem echo on
SET DIR_MYSCRIPT=%~dp0

Rem call :getport COMPORT
set /p COMPORT="Enter COM port (for ex: 'COM53:'): "
if "%COMPORT%" == "" goto ErrorCOM
if "%COMPORT%" == "CON:" goto ErrorCOM

SET TT_MACRO_FILE=%DIR_MYSCRIPT%\ttlMacro_Startup_L4.ttl
SET TT_MACRO_EXE=%DIR_MYSCRIPT%\ttpmacro.exe
echo comport : %COMPORT%
@echo on
%TT_MACRO_EXE%  %TT_MACRO_FILE% %COMPORT%
goto end

:ErrorCOM
echo "Error! No Com port available !"
goto End


:getport comName
    FOR /F "tokens=4 USEBACKQ" %%F IN (`mode`) DO (
		echo %%F
        if %%F NEQ CON: SET %1=%%F
    )
    echo Return : %1

GOTO :EOF

:End
endlocal
Rem pause