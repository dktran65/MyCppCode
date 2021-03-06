set PROJECT=MyCppCode

REM *** 1. Clean up all SCA artifacts *****	
rd /s/q .kwlp
rd /s/q .kwps
rm kwinject.out

REM *** 2. Monitor and Capturing the BuildSpec informatio
kwinject make clean all

REM *** 3. Create Local project DB container from buildspec
kwcheck create -b kwinject.out

REM *** 4. Run Static Analysis on Local project, and will displays the local defects (by default), and systems defects
kwcheck run --system
