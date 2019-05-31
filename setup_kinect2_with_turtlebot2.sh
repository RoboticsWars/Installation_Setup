#!/bin/bash -e
#下载kinect2相关的配置文件
cd ~/
echo -e "\033[42;37mDowloading https://github.com/RoboticsWars/Turtlebot2_Kinect2.git ...\033[0m"
git clone https://github.com/RoboticsWars/Turtlebot2_Kinect2.git
#复制文件
echo -e "\033[42;37mCopying files to related directories...\033[0m"
sudo cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot_description/. /opt/ros/kinetic/share/turtlebot_description/
sudo cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot_navigation/launch/. /opt/ros/kinetic/share/turtlebot_navigation/launch/
cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/iai_kinect2/kinect2_bridge/launch/kinect2_laser.launch ~/catkin_ws/src/iai_kinect2/kinect2_bridge/launch/
echo "export TURTLEBOT_3D_SENSOR=kinect2" >> ~/.bashrc && source ~/.bashrc
echo -e "\033[42;37mSetup complete.\033[0m"
