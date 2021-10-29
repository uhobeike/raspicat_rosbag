#!/bin/bash -xve

source /root/.bashrc
rosparam set /use_sim_time true
rosbag play $(find /home -name *.bag | awk 'NR==2') --clock --topics /tf /tf_static /scan /odom -r $1&
roslaunch raspicat_slam slam_remote_pc.launch