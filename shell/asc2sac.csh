#!/bin/csh -f 
# Luis Rivera, CNRS, France, 2001: conversion from ASCII to SAC
#revised by Hongjun Hui 09/12/2015


setenv SAC_DISPLAY_COPYRIGHT 0 
unset noclobber
set fildrc=/home/hhdhf/new/specfem3d/work/Tibet21/OUTPUT_FILES
cd $fildrc
foreach file (*Z.semv)
 echo $file

# time step
  set T0 = `head -1 $file |          gawk '{print $1}'`
  set T1 = `head -2 $file |tail -1 | gawk '{print $1}'`
  set dt = `echo $T0 $T1 | gawk '{print $2-$1}'`

# second column
  gawk '{print $2}' ${file}   |\
  sed -e "s/[Dd]/ e/"     |\
  gawk '{print int($1*1e8)/1e8, $2}'  |\
  sed -e "s/ e/e/"     >! ${file}_TMP

  sac << LASTLINE
            ra ${file}_TMP
            ch b     $T0
            ch delta $dt
            write ${file}.SAC
            q
LASTLINE

        \rm -f ${file}_TMP
end
date
