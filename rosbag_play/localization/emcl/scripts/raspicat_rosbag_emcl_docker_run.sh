#!/bin/bash -e

docker pull ubeike/raspicat-ros-melodic-rosbag-emcl

xhost +local:docker
docker run -it --rm --gpus all \
    -v $3:/home/catkin_ws/src/raspicat_navigation:rw \
    -v $HOME/raspicat_rosbag_store/:/home/raspicat_rosbag_store:rw \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e LIBGL_ALWAYS_INDIRECT=1 \
    --privileged \
    --net=host \
    --name raspicat_emcl \
ubeike/raspicat-ros-melodic-rosbag-emcl /bin/bash -i -c \
    "bash /run_emcl.sh $4 ${FILE_NAME[$5]} $6 $7"
xhost -local:docker

killall -9 rosmaster