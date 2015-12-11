#!/bin/bash

# this shell is to make stations.in from STATIONS file


drc=/home/hhdhf/new/specfem3d/work/Tibet21/OUTPUT_FILES
cd $drc

gawk '{printf "%-4s %6.4f %6.4f\n", $1,$3/111000,$4/111000}' STATIONS > stations.in 
echo "     111." >> stations.in
date
