set PROJECT=MyCppCode
set SVRLOC=192.168.65.129
REM set SVRLOC=localhost

REM *** 1. Clean up all SCA artifacts *****	
rd /s/q kwtables
rm  -f  trace_out_debug.log  trace_in_debug.log  kwinject.out
make clean

REM *** 2. Create a Build TRACE File
kwinject --debug -T kwinject.trace  make all     >trace_out_debug.log 2>&1

REM *** 3. Create a BUILD-SPEC file from TRACE File
kwinject --debug -t kwinject.trace  -o kwinject  >trace_in_debug.log 2>&1