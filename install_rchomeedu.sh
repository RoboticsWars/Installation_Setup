#!/bin/bash -e
#安装ssh
echo -e "\033[42;37mInstalling ssh ...\033[0m"
sudo apt install openssh-server -y
#新建工作空间
source /opt/ros/kinetic/setup.bash
cd ~/
if [ ! -d "catkin_ws/src" ]; then
  echo -e "\033[42;37mCreating a new workspace named catkin_ws ...\033[0m"
  mkdir -p catkin_ws/src
  echo "source ~/catkin_ws/devel/setup.bash --extend" >> ~/.bashrc
fi
cd ~/catkin_ws/src/
catkin_init_workspace
cd ~/catkin_ws/
catkin_make
source ~/.bashrc
#源码安装Robocup@Home Education的ROS例程：
echo -e "\033[42;37mDownload and build Robocup@Home Education source code. \033[0m"
cd ~/catkin_ws/src/
git clone https://github.com/robocupathomeedu/rc-home-edu-learn-ros.git
cd ~/catkin_ws/
rosdep install --from-paths src --ignore-src -r -y
catkin_make
#安装语音播放
echo -e "\033[42;37mInstalling sound_play packages ...\033[0m"
sudo apt install ros-kinetic-audio-common libasound2 -y
#安装pocketsphinx语音识别
echo -e "\033[42;37mInstalling Pocketsphinx ...\033[0m"
sudo apt install python-pip python-dev build-essential -y
sudo -H pip install --upgrade pip
sudo apt install libasound-dev python-pyaudio -y
sudo -H pip install pyaudio
sudo apt install swig -y
sudo -H pip install pocketsphinx
sudo apt install jackd2 -y
jack_control start
cd ~/Downloads/
wget -O hub4wsj_sc_8k.tar.gz https://sourceforge.net/projects/cmusphinx/files/Acoustic%20and%20Language%20Models/Archive/US%20English%20HUB4WSJ%20Acoustic%20Model/hub4wsj_sc_8k.tar.gz/download
tar -xzvf hub4wsj_sc_8k.tar.gz
sudo mkdir -p /usr/local/share/pocketsphinx/model/en-us/en-us/
sudo cp ~/Downloads/hub4wsj_sc_8k/* /usr/local/share/pocketsphinx/model/en-us/en-us/
#安装科大迅飞语音识别
echo -e "\033[42;37mInstalling xf-ros package ...\033[0m"
sudo apt install mplayer
cd ~
git clone https://github.com/ncnynl/xf-ros.git
cp -r ~/xf-ros/xfei_asr/ ~/catkin_ws/src/
cd ~/catkin_ws/src/xfei_asr/
sed -i "s/ubu/$USER/g" CMakeLists.txt
cd ~/catkin_ws/
rosdep install --from-paths src --ignore-src -r -y
catkin_make
#安装奥比中光Astra的ROS驱动和功能包
echo -e "\033[42;37mInstalling Astra packages ...\033[0m"
cd ~/catkin_ws/src
git clone https://github.com/Interbotix/ros_astra_camera.git -b filterlibrary
git clone https://github.com/Interbotix/ros_astra_launch.git
cd ~/catkin_ws
rosdep install --from-paths src --ignore-src -r -y
catkin_make
rospack profile
echo -e "\033[42;37mSetting udev rules...\033[0m"
rosrun astra_camera create_udev_rules
#安装uvc功能包
echo -e "\033[42;37mInstalling uvc packages ...\033[0m"
sudo apt install ros-kinetic-uvc-camera ros-kinetic-libuvc* -y
#安装usb_cam功能包
echo -e "\033[42;37mInstalling usb_cam package ...\033[0m"
sudo apt install ros-kinetic-usb-cam -y
#安装opencv_apps功能包
echo -e "\033[42;37mInstalling opencv_apps package ...\033[0m"
sudo apt install ros-kinetic-opencv-apps -y
#安装dynamixel_motor功能包
echo -e "\033[42;37mInstalling dynamixel_motor package ...\033[0m"
sudo apt install ros-kinetic-dynamixel-motor -y
#下载HumaRobotics Dynamixel Library
echo -e "\033[42;37mDownloading HumaRobotics Dynamixel Library ...\033[0m"
cd ~/catkin_ws/src/
git clone https://github.com/HumaRobotics/dynamixel_hr.git
echo -e "\033[42;37mInstallation complete! \033[0m"
