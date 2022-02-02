#!/bin/bash -e

. $1/download_list.sh

JOB=0
ALL_JOB=2

(
echo "# Scan download list..."; sleep 1
. $1/download_list.sh
echo $((100*++JOB/ALL_JOB)) ; wait
sleep 1

echo "# Download & Check rosbag..." 
if ! $8 ; then
  . $1/download_rosbag.sh
fi
echo $((100*++JOB/ALL_JOB-1)) ; wait
sleep 0.5

echo "# docker run!"; sleep 1
echo $((100))
) |
zenity --progress \
  --title="Docker emcl System Logs" \
  --width=1000 \
  --auto-close

. $2/raspicat_rosbag_emcl_docker_run.sh