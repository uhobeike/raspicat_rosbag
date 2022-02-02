#!/bin/bash -e

xhost +local:docker
docker run -it --gpus all \
    -v $(rospack find raspicat_slam):/home/catkin_ws/src/raspicat_slam:rw \
    -v $HOME/raspicat_rosbag_store/:/home/raspicat_rosbag_store:rw \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e LIBGL_ALWAYS_INDIRECT=1 \
    -w /home/catkin_ws/src/ \
    --privileged \
    --net=host \
    --name raspicat_gmapping_exec \
ubeike/raspicat-ros-melodic-rosbag-gmapping /bin/bash -i -c \
    "bash "
xhost -local:docker

killall -9 rosmaster