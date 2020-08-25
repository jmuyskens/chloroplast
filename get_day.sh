#!/bin/bash
#./rgb_frame.sh G16 C 2019 197 23 11 barryg16_1982311.tifi

day=$2
satellite=$1
starthour=${3:-0}
endhour=${4:-23}
echo $day $starthour $endhour

get_minute(){
	echo $day
	echo $hour
	output="/mnt/beyonce/data/goes/frames/g${satellite}c_$day$(printf %02d $hour)$(printf %02d $1).jpg"
	echo $output
	#./rgb_frame.sh G17 C 2020 $day $hour $1 $output
}
export -f get_minute
for hour in $(seq $starthour $endhour)
do
	#seq 1 5 59 | parallel get_minute
	output="/mnt/beyonce/data/goes/frames"
	parallel -j 6 ./rgb_frame.sh G$satellite C 2020 $day $hour {} $output ::: $(seq 1 5 59)
	#parallel 'echo "{} /mnt/beyonce/data/goes/frames/g16c_${day}$(printf %02d $hour)$(printf %02d {}).jpg"' ::: $(seq 1 5 59)
done
