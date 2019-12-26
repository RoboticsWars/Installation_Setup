#!/bin/bash -e
#安装奥比中光Astra深度相机驱动
echo -e "\033[42;37mInstalling Letv_Xtion driver ...\033[0m"
#安装UVC库
sudo apt install ros-$ROS_DISTRO-rgbd-launch ros-$ROS_DISTRO-libuvc ros-$ROS_DISTRO-libuvc-camera ros-$ROS_DISTRO-libuvc-ros
cd ~
source /opt/ros/kinetic/setup.bash
if [ ! -d "catkin_ws/src" ]; then
  echo -e "\033[42;37mCreating work space for letv_Xtion...\033[0m"
  mkdir -p catkin_ws/src
  echo "source ~/catkin_ws/devel/setup.bash --extend" >> ~/.bashrc
fi
echo -e "\033[42;37mDownloading Letv_Driver...\033[0m"
#下载astra用的包
cd ~/catkin_ws/src
git clone https://github.com/orbbec/ros_astra_camera

echo -e "\033[42;37mConfigure product id for Letv_Xtion...\033[0m"
#适配Letv_Xtion的Product_ID和Vendor
cd ~/catkin_ws/src/ros_astra_camera/launch
sed -i '68c       <param name="product" value="0x0502"/>' astrapro.launch

echo -e "\033[42;37mConfigure dirver launch file for Letv_Xtion...\033[0m"
#修改驱动launch文件
cd /opt/ros/kinetic/share/turtlebot_bringup/launch/includes/3dsensor/
sudo sed -i '23c  <include file="$(find astra_camera)/launch/astrapro.launch">' astra.launch.xml 

echo -e "\033[42;37mCreate rules file for Letv_Xtion...\033[0m"
#创建rules文件，给摄像头端口加硬链接
cd ~/catkin_ws/src/ros_astra_camera
sudo cp 56-orbbec-usb.rules /etc/udev/rules.d/
sudo service udev reload
sudo service udev restart
sudo usermod -a -G video $USER

echo -e "\033[42;37mCompile the source code...\033[0m"
#编译
cd ~/catkin_ws
catkin_make
rospack profile

#配置环境变量
echo -e "\033[42;37mConfigure the TURTLEBOT_3D_SENSOR...\033[0m"
echo "export TURTLEBOT_3D_SENSOR=astra" >> ~/.bashrc

#Copy libraries
if [  -d "/opt/ros/kinetic/lib/aarch64-linux-gnu" ]; then
  echo -e "\033[42;37mCopy libraries\033[0m"
  sudo cp /opt/ros/kinetic/lib/aarch64-linux-gnu/libopencv_* ../
fi


#安装结束
echo -e "\033[42;37mLetv_Xtion driver installation is done...\033[0m"
