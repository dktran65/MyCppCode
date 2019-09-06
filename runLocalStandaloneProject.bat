set PROJECT=MyCppCode

REM ***** 1. Cleanup and setup new local project folder *****	
rd /s/q .kwlp
rd /s/q .kwps

REM *** 2. Monitor and Capturer Build informatio
kwinject make clean all

REM *** 3. Create Local project DB container
kwcheck create -b kwinject.out

REM *** 4. Run Static Analysis on Local project
kwcheck run
