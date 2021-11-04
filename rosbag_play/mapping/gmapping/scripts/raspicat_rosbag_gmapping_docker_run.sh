#!/bin/bash -e

xhost +local:docker
docker run -it --rm --gpus all \
    -v $2:/home/catkin_ws/src/raspicat_slam:rw \
    -v $HOME/raspicat_rosbag_store/:/home/raspicat_rosbag_store:rw \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e LIBGL_ALWAYS_INDIRECT=1 \
    --privileged \
    --net=host \
    --name raspicat_gmapping \
ubeike/raspicat-ros-melodic-rosbag-gmapping /bin/bash -i -c \
    "bash /run_gmapping.sh ${FILE_NAME[$3]} $4"
xhost -local:docker

killall -9 rosmaster