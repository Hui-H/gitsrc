#!/bin/bash
#Hongjun Hui 09/12/2015

export SAC_DISPLAY_COPYRIGHT=0
unset noclobber


drc=/home/hhdhf/new/specfem3d/work/Tibet21/OUTPUT_FILES
cd $drc

#determine the depth of the source
depth=$(gawk '/depth/ {print $2}' CMTSOLUTION)
evla=$(gawk '/latitude:/ {print $2/111000}' CMTSOLUTION)
evlo=$(gawk '/longitude:/ {print $2/111000}' CMTSOLUTION)

# set time
nzyear=$(date '+%Y')
nzjday=$(date '+%j')

for sacfl in *.SAC; do 

#cut station name
statnm=$(echo $sacfl | cut -c 4-7)

#cut the station network name
statnw=$(echo $sacfl | cut -c 1-2)

#cut the componets system
com=$(echo $sacfl | cut -c 9-11)

#stations location
stla=$(gawk '/'$statnm'/ {print $3/111000}' STATIONS)
stlo=$(gawk '/'$statnm'/ {print $4/111000}' STATIONS)

  sac <<EOF
    read $sacfl
    message "Station Name:"${statnm}
**set event time
    chnhdr nzyear ${nzyear}
    chnhdr nzjday ${nzjday}
    chnhdr nzhour 1
    chnhdr nzmin 1
    chnhdr nzsec 1
    chnhdr nzmsec 1

**set reference time, IO, origin time
    chnhdr iztype IO
    chnhdr ko 0
    chnhdr a 0
    chnhdr O 0


**set the location of event
    chnhdr evla ${evla}
    chnhdr evlo ${evlo}

    chnhdr evdp ${depth}

**set the location of stations
    chnhdr stla ${stla}
    chnhdr stlo ${stlo}

**set the name of station net and station name
    chnhdr knetwk ${statnw}
    chnhdr kstnm ${statnm} 
    chnhdr kcmpnm ${com}

**write in header 
    wh

*rename sacfile, you may need change the year 
    w over &1,nzyear&.&1,nzjday&.0&1,nzhour&.0&1,nzmin&.0&1,nzsec&.0000.&1,knetwk&.&1,kstnm&.00.&1,kcmpnm&.D.SAC

**quit
    quit
EOF
rm $sacfl
done
mkdir ${nzyear}_${nzjday}_01_01
mkdir ascii
mv *D.SAC ${nzyear}_${nzjday}_01_01
mv *semv ascii
date
