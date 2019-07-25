#!/bin/bash -e
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
source ~/catkin_ws/devel/setup.bash --extend
rospack profile
#设置udev规则
echo -e "\033[42;37mSetting udev rules...\033[0m"
rosrun astra_camera create_udev_rules
#设置环境变量
echo -e "\033[42;37mSetting environment variable. \033[0m"
echo "export TURTLEBOT_3D_SENSOR=astra" >> ~/.bashrc
echo -e "\033[42;37mInstallation complete! \033[0m"
