#!/bin/bash -e

# This file is copied in the docker.
# The argument $1 $2 is the argument of "bash /run_gmapping.sh ${FILE_NAME [$4]} $5".
source /root/.bashrc
rosparam set /use_sim_time true
rosrun map_server map_server $(find /home -name $1)&
rosrun rviz rviz -d $(find /home -name $4)&
rosrun tf static_transform_publisher 0 0 0 0 0 0 /odom /base_footprint 100&
rosrun tf static_transform_publisher 0 0 0 0 0 0 /base_footprint /base_link 100&
rosrun tf static_transform_publisher 0.144 0.0 0.04 0 0 0 /base_link /urg_lrf_link 100&
rosbag play $(find /home -name $2) --clock --topics /scan /odom -r $3&
roslaunch raspicat_navigation emcl.launch