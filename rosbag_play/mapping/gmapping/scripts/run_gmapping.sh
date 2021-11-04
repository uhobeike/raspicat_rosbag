#!/bin/bash -e

source /root/.bashrc
rosparam set /use_sim_time true
rosbag play $(find /home -name $1) --clock --topics /tf /tf_static /scan /odom -r $2&
roslaunch raspicat_slam slam_remote_pc.launch