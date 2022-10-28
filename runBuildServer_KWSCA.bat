@echo off
setlocal

:: Validate Portal Variables
@set VD_PROJNAME=MyCppCode
@set VD_SVR_PORTAL=localhost
@set VD_SVR_PORT=8080

:: Klocwork Tools
@set KW_TOOLS=C:\Perforce\Klocwork\kwbuildtools22.3\bin
@set KW_INJECTFILE=kwinject.out

:: Local Project Workspace
@set WORKSPACE=%CD%

:: --------------------------------------------------------------------------------
:: --- [Cleanup Process] --- Old KW artifacts
:: ---
@rd  /S/Q kwtables
@del /F/Q %KW_INJECTFILE%

:: --------------------------------------------------------------------------------
:: --- [kwinject Process] --- Monitor and trace native build, and then generate Build-Spec File
%KW_TOOLS%\kwinject make clean all

:: --------------------------------------------------------------------------------
:: --- [kwbuildproject Process] --- Get checkers policy, get license token, and perform analysis
%KW_TOOLS%\kwbuildproject --url http://%VD_SVR_PORTAL%:%VD_SVR_PORT%/%VD_PROJNAME% -o kwtables %KW_INJECTFILE% --strict --force --replace-path %WORKSPACE%=src

:: --------------------------------------------------------------------------------
:: --- [kwadmin Process] --- Prep data to be Loaded on to Validate Portal
:: #### GET Date YYYYMMDD_HHMMSS

for /f "tokens=2,3,4 delims=/ " %%f in ('date /t') do set d=%%h%%f%%g
for /f "tokens=1,2 delims=: " %%f in ('time /t') do set t=%%f%%g
set DATE_TIME=%d%_%t: =0%

%KW_TOOLS%\kwadmin --url http://%VD_SVR_PORTAL%:%VD_SVR_PORT% load %VD_PROJNAME% kwtables --name build_%DATE_TIME%

endlocal
echo on