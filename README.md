# raspicat_rosbag

# Overview explanation

## raspicat_rosbag/rosbag_play/gmapping

* [こちらのgoogleドライブ](https://drive.google.com/file/d/1KuhIFHGd5TuUXpT7oKzMXzhHdzOvfY0v/view?usp=sharing)からrosbagを持ってきてgmappingを実行しパラメータ調整を行うためのパッケージです。

* rosbagがダウンロード済みの場合は再ダウンロードは行われません。

* ~/tsukuba_bag以下に圧縮済みrosbagがダウンロードされ解凍されます。

# How to use

## raspicat_rosbag/rosbag_play/gmapping

* 0thターミナル(事前準備←マウント元の用意)
```
mkdir -p ~/raspicat_rosbagslam_ws/src && cd ~/raspicat_rosbagslam_ws/src 
git clone https://github.com/CIT-Autonomous-Robot-Lab/raspicat_slam.git
cd ~/raspicat_rosbagslam_ws/
catkin build
source ~/raspicat_rosbagslam_ws/devel/setup.bash
```

* 1stターミナル(システムの起動方法)
```
roslaunch raspicat_rosbag rosbag_play_gmapping.launch
```

* 2ndターミナル(マウント先にmapを保存する方法)
```
docker exec -i -t raspicat_gmapping bash
cd maps
rosrun map_server map_saver -f map
```