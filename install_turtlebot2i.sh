#!/bin/bash -e
cd ~
if [ ! -d "~/turtlebot2i/src" ]; then
  mkdir -p ~/turtlebot2i/src
fi
source /opt/ros/kinetic/setup.bash
cd ~/turtlebot2i/src
git clone https://github.com/Interbotix/turtlebot2i.git
git clone https://github.com/Interbotix/arbotix_ros.git -b turtlebot2i
git clone https://github.com/Interbotix/phantomx_pincher_arm.git
git clone https://github.com/Interbotix/ros_astra_camera -b filterlibrary
git clone https://github.com/Interbotix/ros_astra_launch
cd ~/turtlebot2i
catkin_make
echo "source ~/turtlebot2i/devel/setup.bash --extended" >> ~/.bashrc
