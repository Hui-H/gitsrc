#!/bin/bash

#to copy response files

currentdrc=`pwd`
drc=/home/hhdhf/new/specfem3d/work/Tibet21/OUTPUT_FILES
cd $drc
nloop=$(gawk '{print $1}' stations.in | wc -l)
day=$(date '+%d')
mon=$(date '+%m')
yea=$(date '+%Y')

loop=1
mkdir resp_files
while [ "$loop" -lt "$nloop" ]
  do 
    stanm=$(head -$loop stations.in  | tail -1 | gawk '{print $1}')
    cat $currentdrc/response.file > SAC_"$stanm"_resp_z_"$day"_"$mon"_"$yea"
    ((loop += 1))
  done
#mk response.list
ls SAC*resp* > response.list
mv SAC*resp* response.list  resp_files
date
