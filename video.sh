#!/bin/bash
sat=$1
year=$2
doy=$(printf "%03d" $((10#$3)))
ffmpeg -pattern_type "glob" -i "/mnt/beyonce/data/goes/frames/G${sat}_${year}${doy}*.jpg" -pix_fmt yuv420p "/mnt/beyonce/data/goes/video/G${sat}_${year}${doy}.mp4" -y
