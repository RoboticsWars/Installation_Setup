#!/bin/bash -e
source /opt/ros/kinetic/setup.bash
source /home/turtlebot/catkin_ws/devel/setup.bash
export TURTLEBOT_3D_SENSOR=kinect2_rplidar_a2
export TURTLEBOT_BATTERY=None
export TURTLEBOT_STACKS=circle_board
export ROS_MASTER_URI=http://192.168.0.125:11311
export ROS_HOSTNAME=192.168.0.125
export TURTLEBOT_MAP_FILE=$HOME/map_20190711.yaml
roslaunch turtlebot_bringup kobuki_xs_navigation.launch map_file:=/home/turtlebot/map_20190711.yaml
