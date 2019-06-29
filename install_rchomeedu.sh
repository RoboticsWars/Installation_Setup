#!/bin/bash -e
#安装ssh
echo -e "\033[42;37mInstalling ssh ...\033[0m"
sudo apt install openssh-server -y
#新建工作空间
echo -e "\033[42;37mCreating a new workspace named catkin_ws ...\033[0m"
source /opt/ros/kinetic/setup.bash
cd ~/
mkdir -p catkin_ws/src
cd catkin_ws/src/
catkin_init_workspace
cd ..
catkin_make
echo "source ~/catkin_ws/devel/setup.bash --extended" >> ~/.bashrc
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
wget https://sourceforge.net/projects/cmusphinx/files/Acoustic%20and%20Language%20Models/Archive/US%20English%20HUB4WSJ%20Acoustic%20Model/hub4wsj_sc_8k.tar.gz/download
mv download hub4wsj_sc_8k.tar.gz
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
sed -i "s/ubu/turtlebot/g"  CMakeLists.txt
cd ~/catkin_ws/
rosdep install --from-paths src --ignore-src -r -y
catkin_make
#安装奥比中光Astra深度相机驱动
echo -e "\033[42;37mInstalling Astra driver ...\033[0m"
cd ~/Downloads/
wget http://dl.orbbec3d.com/dist/openni2/OpenNI_2.3.0.55.zip
unzip OpenNI_2.3.0.55.zip
cd OpenNI_2.3.0.55/Linux/OpenNI-Linux-x64-2.3.0.55/
chmod a+x install.sh
sudo ./install.sh
source OpenNIDevEnvironment
cd Samples/SimpleViewer
make
#安装奥比中光Astra的ROS功能包
echo -e "\033[42;37mInstalling Astra packages ...\033[0m"
sudo apt install ros-kinetic-astra-camera ros-kinetic-astra-launch -y
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
cd ~/catkin_ws/src/
git clone https://github.com/HumaRobotics/dynamixel_hr.git
