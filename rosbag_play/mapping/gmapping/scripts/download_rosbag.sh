#!/bin/bash -xve

ROSBAG_DIR=~/tsukuba_bag
FILE_ID=1KuhIFHGd5TuUXpT7oKzMXzhHdzOvfY0v
FILE_NAME=tsukuba_bag_2021-10-23-14-07.bag

mkdir -p $ROSBAG_DIR 
cd $ROSBAG_DIR

ROSBAG_FILE_FIND=$(find ~/tsukuba_bag/ -name tsukuba_bag_2021-10-23-14-07.bag)
ROSBAG_SIZE=$(du -s $ROSBAG_FILE_FIND | awk '{print $1}')



if [[ $ROSBAG_FILE_FIND != $ROSBAG_DIR/$FILE_NAME ]]; then
  curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /dev/null
  CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
  curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID}" -o ${FILE_NAME}

  if [ $ROSBAG_SIZE -lt 4000000 ]; then
    rosbag decompress $FILE_NAME
    printf '\033[42m%s\033[m\n' 'ROSBAG DOWNLOAD SUCCEED'
  fi
elif [[ $ROSBAG_FILE_FIND == $ROSBAG_DIR/$FILE_NAME ]]; then
  if [ $ROSBAG_SIZE -lt 4000000 ]; then
    rosbag decompress $ROSBAG_FILE_FIND
    printf '\033[42m%s\033[m\n' 'ROSBAG DOWNLOAD SUCCEED'
  else
    printf '\033[37m%s\033[m\n' 'ALREADY EXIT ROSBAG'
  fi
fi