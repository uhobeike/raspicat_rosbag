#!/bin/bash -e

# This file is copied in the docker.
# ex) bash run_emcl_exec.sh 4 1 map_tsukuba.yaml raspicat_navigation_3d.rviz
source /root/.bashrc
. download_list.sh
roscore&
sleep 1
rosparam set /use_sim_time true
rosrun map_server map_server $(find /home -name $3)&
rosrun rviz rviz -d $(find /home -name $4)&
rosrun tf static_transform_publisher 0.144 0.0 0.04 0 0 0 /base_link /urg_lrf_link 100&
rosbag play $(find /home -name ${FILE_NAME[$1]}) --clock --topics /tf /tf_static /scan /odom -r $2&
roslaunch raspicat_navigation emcl.launch
killall -9 rosmaster