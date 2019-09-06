set projectName=MyCppCode
set SVRLOC=192.168.65.129
REM set SVRLOC=localhost

REM *** 1. We should already have CHESS project on Klocwork Server
make clean

REM *** 2. Normal build, since we already have CHESS.out file from initial creation
kwinject make  all

REM *** 3. Next Force a full Analysis
kwbuildproject --url http://%SVRLOC%:8080/%projectName% -o kwtables kwinject.out --force --replace-path %CD%=%projectName%

REM *** 4. we load our result with kwadmin and load to the Klocwork Server
REM kwadmin --url http://localhost:8080 load %projectName%  kwtables