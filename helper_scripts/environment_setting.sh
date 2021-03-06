#!/bin/bash -xve

sudo apt install -y python-catkin-tools

mkdir -p ~/raspicat_rosbagslam_ws/src && cd ~/raspicat_rosbagslam_ws/src

git clone https://github.com/CIT-Autonomous-Robot-Lab/raspicat_slam.git
git clone https://github.com/CIT-Autonomous-Robot-Lab/raspicat_navigation.git
git clone https://github.com/CIT-Autonomous-Robot-Lab/emcl.git
svn export https://github.com/CIT-Autonomous-Robot-Lab/mcl_ros/trunk/src/mcl_ros
git clone https://github.com/uhobeike/raspicat_rosbag.git

rosdep install -r -y --from-paths --ignore-src .
cd ~/raspicat_rosbagslam_ws/
catkin build
source ~/raspicat_rosbagslam_ws/devel/setup.bash