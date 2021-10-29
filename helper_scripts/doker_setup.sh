#!/bin/bash -xve

sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker

echo -n "rebootしても、よろしいですか？ [Y/n]: "
read ANS

case $ANS in
  "" | [Yy]* )
    echo "再起動します"
    sudo reboot
    ;;
  * )
    echo "終了"
    ;;
esac