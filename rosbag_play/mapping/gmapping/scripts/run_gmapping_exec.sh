#!/bin/bash -e

# This file is copied in the docker.
# ex) . run_gmapping.sh 3 1
source /root/.bashrc
. download_list.sh
rosocre |&
wait
rosparam set /use_sim_time true
rosbag play $(find /home -name ${FILE_NAME[$1]}) --clock --topics /tf /tf_static /scan /odom -r $2 |&
roslaunch raspicat_slam slam_remote_pc.launch