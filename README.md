# raspicat_rosbag

[![docker-image-relese](https://github.com/uhobeike/raspicat_rosbag/actions/workflows/docker-image-relese.yaml/badge.svg)](https://github.com/uhobeike/raspicat_rosbag/actions/workflows/docker-image-relese.yaml)

# Overview explanation

## raspicat_rosbag/rosbag_play/gmapping

* [こちらのgoogleドライブ](https://drive.google.com/drive/folders/10M9LNWEwlFVunHTv-vx0vhNK5xqopGc_?usp=sharing)からrosbagをダウンロードしgmappingを実行しパラメータ調整を行うためのパッケージです。

* rosbagがダウンロード済みの場合は再ダウンロードは行われません。

* ~/raspicat_rosbag_store以下に圧縮済みrosbagがダウンロードされ解凍されます。

# How to use

## raspicat_rosbag/rosbag_play/gmapping

* 0thターミナル(事前準備←マウント元の用意&環境構築)
```
mkdir -p ~/raspicat_rosbagslam_ws/src && cd ~/raspicat_rosbagslam_ws/src 
git clone https://github.com/CIT-Autonomous-Robot-Lab/raspicat_slam.git
git clone https://github.com/uhobeike/raspicat_rosbag.git
cd ~/raspicat_rosbagslam_ws/
catkin build
source ~/raspicat_rosbagslam_ws/devel/setup.bash
```

* 1stターミナル(システムの起動方法)
```
roslaunch raspicat_rosbag rosbag_play_gmapping.launch rosbag_play_speed:=1.0
```

* 2ndターミナル(マウント元にmapを保存する方法)
```
docker exec -i -t raspicat_gmapping bash
cd maps
rosrun map_server map_saver -f map
↑(raspicat_rosbag_ws/src/raspicat_slam/maps/下に保存されます。)
```

## How to deal with error

* [以下のエラーが出た時の対策方法](https://github.com/uhobeike/raspicat_rosbag/issues/8)

```
docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/create?name=raspicat_gmapping": dial unix /var/run/docker.sock: connect: permission denied.
```


* [以下のエラーが出た時の対策方法](https://github.com/uhobeike/raspicat_rosbag/issues/9)
```
docker: Error response from daemon: could not select device driver "" with capabilities: [[gpu]].
```