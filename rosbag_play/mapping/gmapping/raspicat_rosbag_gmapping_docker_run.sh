#!/bin/bash -xve

xhost +local:docker && \
docker run -it --rm --gpus all \
    -v $1:/home/catkin_ws/src/raspicat_slam:rw \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e LIBGL_ALWAYS_INDIRECT=1 \
    --privileged \
    --net=host \
ubeike/raspicat-ros-melodic-rosbag-gmapping /bin/bash -c \
    "source /home/.bashrc && \
    ls && \
    /bin/bash" && \
xhost -local:docker