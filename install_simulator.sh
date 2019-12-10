#!/bin/bash
echo -e "\033[42;37mInstalling gazebo package...\033[0m"
sudo apt-get update
sudo apt-get install ros-kinetic-gazebo-ros-pkgs ros-kinetic-gazebo-ros-control
sudo apt-get install ros-kinetic-turtlebot ros-kinetic-turtlebot-*
echo -e "\033[42;37mSetting world file...\033[0m"
echo "TURTLEBOT_GAZEBO_WORLD_FILE=\"/opt/ros/kinetic/share/turtlebot_gazebo/worlds/playground.world\"" >> ~/.bashrc
echo -e "\033[42;37mDownloading robot models...\033[0m"
cd ~/.gazebo/
mkdir  models
cd models/
wget http://file.ncnynl.com/ros/gazebo_models.txt
wget -i gazebo_models.txt
ls model.tar.g* | xargs -n1 tar xzvf
echo -e "\033[42;37mInstallation done.\033[0m"