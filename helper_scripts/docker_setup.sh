#!/bin/bash -e

# Add $USER docker group
if [[ -z $(cat /etc/group | grep docker) ]]; then
  sudo groupadd docker
fi

if [ $(groups $USER | grep -i -o $USER | wc -l) != 2 ]; then
  sudo gpasswd -a $USER docker
  sudo systemctl restart docker

  echo -n "rebootしても、よろしいですか？ [Y/n]: "
  read ANS

  case $ANS in
    "" | [Yy]* )
      echo "再起動します"
      printf '\033[42m%s\033[m→  %s\n' 'SUCCEED' "$0"
      sleep 1
      sudo reboot
      ;;
    * )
      echo "終了"
      ;;
  esac
fi

printf '\033[42m%s\033[m→  %s\n' 'SUCCEED' "$0"