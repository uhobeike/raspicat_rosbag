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
. $1/download_rosbag.sh
echo $((100*++JOB/ALL_JOB-1)) ; wait
sleep 0.5

echo "# docker run!"; sleep 1
echo $((100))
) |
zenity --progress \
  --title="Docker mcl_ros System Logs" \
  --width=1000 \
  --auto-close

. $2/raspicat_rosbag_mcl_ros_docker_run.sh