#!/bin/bash -e

if "${1}"; then
  cp $(rospack find raspicat_slam)/maps/*.pgm $(rospack find raspicat_slam)/maps/*.yaml $(rospack find raspicat_navigation)/config/maps/
  printf '\033[42m%s\033[m→  %s\n' 'SUCCEED' "move map_file navigation_dir"
fi