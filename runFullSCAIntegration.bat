set PROJECT=MyCppCode
set SVRLOC=192.168.65.129
REM set SVRLOC=localhost

REM *** 1. Clean up all SCA artifacts *****	
rd /s/q kwtables
rm kwinject.out

REM *** 2. Monitor and Capturing the BuildSpec informatio
kwinject --overwrite make clean all

REM *** 3. Run Build and SCA on project, reference to KW-Portal project, based on buildspec, and produce DB tables for output.
kwbuildproject --url http://%SVRLOC%:8080/%PROJECT% -o kwtables kwinject.out --force --replace-path %CD%=%PROJECT%

REM *** 4. Then Load the Results to the KW-Server Project Container
kwadmin --url http://%SVRLOC%:8080 load %PROJECT%  kwtables --name JCI_kw19v2_%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%_%TIME:~3,2%%TIME:~6,2%