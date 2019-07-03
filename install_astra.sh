#!/bin/bash -e
#安装奥比中光Astra深度相机驱动
#echo -e "\033[42;37mInstalling Astra driver ...\033[0m"
#cd ~/Downloads/
#wget http://dl.orbbec3d.com/dist/openni2/OpenNI_2.3.0.55.zip
#unzip OpenNI_2.3.0.55.zip
#cd OpenNI_2.3.0.55/Linux/OpenNI-Linux-x64-2.3.0.55/
#chmod a+x install.sh
#sudo ./install.sh
#source OpenNIDevEnvironment
#cd Samples/SimpleViewer
#make
#安装奥比中光Astra深度相机驱动和功能包
echo -e "\033[42;37mInstallating astra driver and ros packages...\033[0m"
source /opt/ros/kinetic/setup.bash
cd ~
if [ ! -d "catkin_ws/src" ]; then
  echo -e "\033[42;37mCreating work space for astra...\033[0m"
  mkdir -p catkin_ws/src
  echo "source ~/catkin_ws/devel/setup.bash --extend" >> ~/.bashrc
fi
cd ~/catkin_ws/src
git clone https://github.com/Interbotix/ros_astra_camera.git -b filterlibrary
git clone https://github.com/Interbotix/ros_astra_launch.git
cd ~/catkin_ws
rosdep install --from-paths src --ignore-src -r -y
catkin_make
rospack profile
#设置udev规则
echo -e "\033[42;37mSetting udev rules...\033[0m"
rosrun astra_camera create_udev_rules
echo -e "\033[42;37mInstallation complete! \033[0m"
