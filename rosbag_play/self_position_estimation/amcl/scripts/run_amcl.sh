#!/bin/bash -e

# This file is copied in the docker.
# The argument $1 $2 is the argument of "bash /run_gmapping.sh ${FILE_NAME [$4]} $5".
source /root/.bashrc
rosparam set /use_sim_time true
rosrun map_server map_server $(find /home -name $1)&
roslaunch raspicat_navigation amcl.launch&
rosbag play $(find /home -name $2) --clock --topics /tf /tf_static /scan /odom -r $3&
rosrun rviz rviz -d $(find /home -name $4)