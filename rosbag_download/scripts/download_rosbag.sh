#!/bin/bash -e

ROSBAG_DIR=~/raspicat_rosbag_store

mkdir -p $ROSBAG_DIR 
cd $ROSBAG_DIR

for ((indent=0; indent<${#FILE_ID[@]}; indent++))
do
  ROSBAG_FILE_FIND=$(find ~/raspicat_rosbag_store/ -name ${FILE_NAME[$indent]})

  if [[ $ROSBAG_FILE_FIND != $ROSBAG_DIR/${FILE_NAME[$indent]} ]]; then
    curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID[$indent]}" > /dev/null
    CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
    curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=${FILE_ID[$indent]}" -o ${FILE_NAME[$indent]}
    printf '\033[42m%s\033[m→  %s\n' 'DOWNLOAD SUCCEED' ${FILE_NAME[$indent]}
    ROSBAG_FILE_FIND=$(find ~/raspicat_rosbag_store/ -name ${FILE_NAME[$indent]})
    rosbag decompress ${FILE_NAME[$indent]}
    printf '\033[42m%s\033[m→  %s\n' 'ROSBAG DECOMPRESS SUCCEED' ${FILE_NAME[$indent]} 
  elif [[ $ROSBAG_FILE_FIND == $ROSBAG_DIR/${FILE_NAME[$indent]} ]]; then
    rosbag decompress ${ROSBAG_FILE_FIND}
    printf '\033[42m%s%s%s%s%s\033[m→  %s\n' 'ROSBAG DECOMPRESS SUCCEED[' $(($indent+1)) '/' ${#FILE_ID[@]} ']' ${FILE_NAME[$indent]}
  fi
done