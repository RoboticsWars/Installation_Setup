#!/bin/bash -e
#设置ROS源为清华源
echo -e "\033[42;37mSetting up your sources.list...\033[0m"
sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
#获取公钥
echo -e "\033[42;37mSetting up your keys\033[0m"
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
#安装
echo -e "\033[42;37mInstallating ROS-Desktop-Full...\033[0m"
sudo apt update
sudo apt install ros-kinetic-desktop-full -y
#配置依赖项
echo -e "\033[42;37mInitializing rosdep...\033[0m"
apt search ros-kinetic
sudo rosdep init
rosdep update
#环境变量设置
echo -e "\033[42;37mEnvironment setup\033[0m"
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source /opt/ros/kinetic/setup.bash
source ~/.bashrc
#安装编译功能包所需的依赖项
echo -e "\033[42;37mDependencies for building packages\033[0m"
sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential -y
#安装turtlebot官方功能包
echo -e "\033[42;37mInstalling turtlebot packages...\033[0m"
sudo apt install ros-kinetic-turtlebot ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-rviz-launchers -y
echo -e "\033[42;37mROS for turtlebot is installed!\033[0m"
