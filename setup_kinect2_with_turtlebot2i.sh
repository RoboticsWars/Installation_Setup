#!/bin/bash -e
#此文件替换原版文件的配置文件
#下载kinect2相关的配置文件
cd ~/
if [ ! -d "Turtlebot2_Kinect2" ]; then
  echo -e "\033[42;37mDowloading https://github.com/RoboticsWars/Turtlebot2_Kinect2.git ...\033[0m"
  git clone https://github.com/RoboticsWars/Turtlebot2_Kinect2.git
else
  cd Turtlebot2_Kinect2
  git pull
fi
#备份原3dsensor.launch文件
echo -e "\033[42;37mMake a backup of ~/turtlebot2i/src/turtlebot2i/turtlebot2i_bringup/launch/3dsensor.launch\033[0m"
cp ~/turtlebot2i/src/turtlebot2i/turtlebot2i_bringu/launch/3dsensor.launch ~/turtlebot2i/src/turtlebot2i/turtlebot2i_bringu/launch/3dsensor.launch.backup
#复制相关文件
echo -e "\033[42;37mCopying files to related directories...\033[0m"
cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot2i_bringup/. ~/turtlebot2i/src/Turtlebot2i_KinectV2_SR300/turtlebot2i_bringup/
cp ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot2i_description/. ~/turtlebot2i/src/Turtlebot2i_KinectV2_SR300/turtlebot2i_description/
echo "export TURTLEBOT_3D_SENSOR=kinect2" >> ~/.bashrc && source ~/.bashrc
echo -e "\033[42;37mSetup complete.\033[0m"
