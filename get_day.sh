#!/bin/bash
#./rgb_frame.sh G16 C 2019 197 23 11 barryg16_1982311.tif
echo "Bash version ${BASH_VERSION}..."
day=$1

for hour in $(seq 0 0)
do
  for minute in $(seq 1 5 59)
  do
    ./rgb_frame.sh G16 C 2019 $day $hour $minute "frames/g16c_${day}$(printf %02d $hour)$(printf %02d $minute).jpg"
  done
done
