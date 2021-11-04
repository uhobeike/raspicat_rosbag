#!/bin/bash -e

. $1/download_list.sh

job=0
all_job=${#FILE_ID[@]}
echo $all_job

(
echo "# Scan download list..."; sleep 1
. $1/download_list.sh
echo $((100*++job/all_job)) ; wait
sleep 1

echo "# Download & Check rosbag..." 
. $1/download_rosbag.sh
echo $((100*++job/all_job-1)) ; wait
sleep 0.5

echo "# docker run!"; sleep 1
echo $((100))
) |
zenity --progress \
  --title="Docker Mapping System Logs" \
  --width=1000 \
  --auto-close

. $1/raspicat_rosbag_gmapping_docker_run.sh