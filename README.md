# raspicat_rosbag

[![docker-image-relese](https://github.com/uhobeike/raspicat_rosbag/actions/workflows/docker-image-relese.yaml/badge.svg)](https://github.com/uhobeike/raspicat_rosbag/actions/workflows/docker-image-relese.yaml)

* [こちらのgoogleドライブ](https://drive.google.com/drive/folders/10M9LNWEwlFVunHTv-vx0vhNK5xqopGc_?usp=sharing)からrosbagをダウンロードし
dockerを用いてマッピングや自己位置推定を実行することでパラメータ調整を行うためのパッケージです。

* rosbagがダウンロード済みの場合は再ダウンロードは行われません。

* ~/raspicat_rosbag_store以下に圧縮済みrosbagがダウンロードされ解凍されます。

# How to use

## 環境構築

* 以下のスクリプトを実行
```
./helper_scripts/environment_setting.sh
```

## raspicat_rosbag/rosbag_play/gmapping

* 1stターミナル(システムの起動方法)
```
roslaunch raspicat_rosbag rosbag_play_gmapping.launch rosbag_play_file_number:=3 rosbag_play_speed:=1.0 save_map_to_raspicat_navigation:=true
```
👆(`save_map_to_raspicat_navigation:=true`にすることでroslaunch終了前にraspicat_slam/maps/にあるマップデータがraspicat_navigation/config/maps/コピーされます。rosbag_play_file_number:=0は[ここに列挙されている配列のインデックス](https://github.com/uhobeike/raspicat_rosbag/blob/master/rosbag_download/scripts/download_list.sh)です。)
* 2ndターミナル(マウント元にmapを保存する方法)
```
docker exec -i -t raspicat_gmapping bash -c "cd maps;bash"
rosrun map_server map_saver -f map
```
👆(raspicat_rosbag_ws/src/raspicat_slam/maps/下に保存されます。)

* 調整するパラメータファイル

[`raspicat_slam/launch/slam_remote_pc.launch`](https://github.com/CIT-Autonomous-Robot-Lab/raspicat_slam/blob/master/launch/slam_remote_pc.launch)

## raspicat_rosbag/rosbag_play/amcl

* 1stターミナル(システムの起動方法)
```
roslaunch raspicat_rosbag rosbag_play_amcl.launch rosbag_play_file_number:=2 rosbag_play_speed:=1.0 map_file:=map.yaml
```

* 調整するパラメータファイル

[`raspicat_navigation/launch/amcl.launch`](https://github.com/CIT-Autonomous-Robot-Lab/raspicat_navigation/blob/master/launch/amcl.launch)

## How to deal with error

* [以下のエラーが出た時の対策方法](https://github.com/uhobeike/raspicat_rosbag/issues/8)

```
docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/create?name=raspicat_gmapping": dial unix /var/run/docker.sock: connect: permission denied.
```


* [以下のエラーが出た時の対策方法](https://github.com/uhobeike/raspicat_rosbag/issues/9)
```
docker: Error response from daemon: could not select device driver "" with capabilities: [[gpu]].
```