#!/bin/bash -e

# This file is copied in the docker.
# ex) bash run_amcl_exec.sh 4 1 map_tsukuba.yaml raspicat_navigation_3d.rviz
source /root/.bashrc
. download_list.sh
roscore&
sleep 1
rosparam set /use_sim_time true
rosrun map_server map_server $(find /home -name $3)&
rosrun rviz rviz -d $(find /home -name $4)&
rosbag play $(find /home -name ${FILE_NAME[$1]}) --clock --topics /tf /tf_static /scan /odom -r $2&
roslaunch raspicat_navigation amcl.launch
killall -9 rosmaster