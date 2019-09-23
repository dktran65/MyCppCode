echo "*** 1. Clean up all SCA artifacts *****"	
rm -rf /s/q kwtables
echo ""
echo "*** 2. Create a Build TRACE File"
kwinject --overwrite --debug -T kwinjectTrace.txt  make clean all   >trace_out_debug.log 2>&1
echo ""
echo "*** 3. Create a BUILD-SPEC file from TRACE File"
kwinject --overwrite --debug -t kwinjectTrace.txt  -o kwinject.out  >trace_in_debug.log 2>&1