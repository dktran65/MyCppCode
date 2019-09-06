set PROJECT=MyCppCode
SET KWPORTAL=192.168.65.129
REM set SVRLOC=localhost

REM ***** 1. Cleanup and setup new local project folder *****	
rd /s/q .kwlp
rd /s/q .kwps

REM *** 2. Monitor and Capturer Build informatio
kwinject make clean all

REM *** 3. Create Local project DB container with link to the connected DB inform on KW Server
kwcheck create --url http://%KWPORTAL%:8080/%PROJECT% -b kwinject.out

REM *** 4. Run Static Analysis on Local project
kwcheck run
