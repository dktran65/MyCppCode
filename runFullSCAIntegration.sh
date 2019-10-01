Ps#!/bin/bash
PROJPATH=/home/vmdemo/AAASanboxProjects/MyCppCode
PROJNAME=MyCppCode
# SVRLOC=192.168.65.129
SVRLOC=localhost

# *** 1. Clean up all SCA artifacts *****	
rd /s/q kwtables
rm kwinject.out

# *** 2. Monitor and Capturing the BuildSpec informatio
kwinject --overwrite make clean all

# *** 3. Run Build and SCA on project, reference to KW-Portal project, based on buildspec, and produce DB tables for output.
kwbuildproject --url http://$SVRLOC:8080/$PROJNAME -o kwtables kwinject.out --force -replace-path $PWD=$PROJNAME

# *** 4. Then Load the Results to the KW-Server Project Container
kwadmin --url http://$SVRLOC:8080 load $PROJNAME kwtables --name IP60_Kw19v2
