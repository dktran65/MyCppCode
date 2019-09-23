s#!/bin/bash
PROJPATH=/home/vmdemo/AAASanboxProjects/MyCppCode
PROJNAME=MyCppCode

echo "\n************************************************************************************" | tee -a DataTracker.txt
echo "*****  TRACKING TIME and DISKSPACE USAGE - Start: $(date) *****" | tee -a DataTracker.txt
echo "************************************************************************************" | tee -a DataTracker.txt
echo "--- Project diskspace used BEFORE Clean Process = $(du -sh $PROJPATH)" | tee -a DataTracker.txt

echo "*** Start Cleaning Process ***" | tee -a DataTracker.txt
START=$(date +%s.%N)
make clean
rm -rf kwinject.out
rm -rf kwtables
END=$(date +%s.%N)
echo "--- End Cleaning Process ---" | tee -a DataTracker.txt
echo "--- Project diskspace used AFTER Clean Process = $(du -sh $PROJPATH)" | tee -a DataTracker.txt
eval "echo Cleaning process takes = $(date -ud "@$(echo "($END - $START)+1" | bc)" +'$((%s/3600/24)) days %H hours %M minutes %S seconds')" | tee -a DataTracker.txt

###############################################################################
### Clean and capture the build specification
###############################################################################

echo "*** Starting kwinject to Trace and Generate Build-Spec ***" | tee -a DataTracker.txt
START=$(date +%s.%N)
kwinject --overwrite  make all
END=$(date +%s.%N)
echo "--- Ending of Trace and Generate build spec ---" | tee -a DataTracker.txt
echo "--- Project diskspace used AFTER kwinject Process = $(du -sh $PROJPATH)" | tee -a DataTracker.txt
eval "echo kwinject process takes = $(date -ud "@$(echo "($END - $START)+1" | bc)" +'$((%s/3600/24)) days %H hours %M minutes %S seconds')" | tee -a DataTracker.txt


###############################################################################
### This will take the generate build-spec file (kwinject.out) as an input file, and then run SCA, and generate results in kwtables folder
###############################################################################
echo "*** Starting kwbuildproject SCA ***" | tee -a DataTracker.txt
START=$(date +%s.%N)
kwbuildproject --url http://localhost:8080/$PROJNAME  -o kwtables  kwinject.out --force --replace-path $PWD=$PROJNAME
END=$(date +%s.%N)
echo "--- Ending kwbuildproject SCA ---" | tee -a DataTracker.txt
echo "--- Project diskspace used AFTER kwbuildproject Process = $(du -sh $PROJPATH)" | tee -a DataTracker.txt
eval "echo kwbuildproject process takes = $(date -ud "@$(echo "($END - $START)+1" | bc)" +'$((%s/3600/24)) days %H hours %M minutes %S seconds')" | tee -a DataTracker.txt

###############################################################################
### Then Publish Result to the Klocwork SERVER project container
###############################################################################
echo "*** Starting kwadmin LOAD ***" | tee -a DataTracker.txt
START=$(date +%s.%N)
kwadmin --url http://localhost:8080 load $PROJNAME kwtables --name Kw19.2_$(date +%m%e%g_%H%M%S)
END=$(date +%s.%N)
echo "--- Ending kwadmin LOAD ---" | tee -a DataTracker.txt
echo "--- Project diskspace used AFTER kwadmin Process = $(du -sh $PROJPATH)" | tee -a DataTracker.txt
eval "echo kwadmin load process takes = $(date -ud "@$(echo "($END - $START)+1" | bc)" +'$((%s/3600/24)) days %H hours %M minutes %S seconds')" | tee -a DataTracker.txt
echo "********** The Script run completed: $(date) **********\n" | tee -a DataTracker.txt

