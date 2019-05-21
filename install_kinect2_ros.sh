#!/bin/bash -e
#iai_kinect2安装
echo -e "\033[42;37mCreating work space for iai_kinect2...\033[0m"
echo "export ROS_DISTRO=kinetic" >> ~/.bashrc
export ROS_DISTRO=kinetic
#不source就无法在脚本使用catkin_make
source /opt/ros/kinetic/setup.bash
cd ~
if [ ! -d "catkin_ws/src" ]; then
  mkdir -p catkin_ws/src
fi
echo -e "\033[42;37mDownloading iai_kinect2...\033[0m"
cd ~/catkin_ws/src/
#开始下载iai_kinect2
git clone https://github.com/code-iai/iai_kinect2.git
cd ~/catkin_ws/src/iai_kinect2
#配置依赖项
echo -e "\033[42;37mInstalling dependences for iai_kinect2...\033[0m"
rosdep install -r --from-paths .
#编译iai_kinect2
echo -e "\033[42;37mBuilding iai_kinect2...\033[0m"
cd ~/catkin_ws
catkin_make -DCMAKE_BUILD_TYPE="Release"
echo "source ~/catkin_ws/devel/setup.bash --extended" >> ~/.bashrc
ROS_PACKAGE_PATH=~/catkin_ws/src:$ROS_PACKAGE_PATH
ROS_WORKSPACE=~/catkin_ws/src
source ~/.bashrc
source ~/catkin_ws/devel/setup.bash
rospack profile
echo -e "\033[42;37mPlease set depth_method to opengl and reg_method to cpu in ~/catkin_ws/src/iai_kinect2/kinect2_bridge/launch/kinect2_bridge.launch!\033[0m"
