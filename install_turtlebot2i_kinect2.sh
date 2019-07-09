#!/bin/bash -e
cd ~
source /opt/ros/kinetic/setup.bash
#安装Realsense功能包
echo -e "\033[42;37mInstalling realsense packages...\033[0m"
sudo apt install ros-kinetic-librealsense ros-kinetic-realsense-camera -y
#安装rtabmap_ros功能包
echo -e "\033[42;37mInstalling rtabmap_ros packages...\033[0m"
sudo apt install ros-kinetic-rtabmap-ros -y
#创建turtlebot2i工作空间
cd ~/
if [ ! -d "turtlebot2i/src" ]; then
  echo -e "\033[42;37mCreating work space for turtlebot2i...\033[0m"
  mkdir -p ~/turtlebot2i/src
  echo "source ~/turtlebot2i/devel/setup.bash --extend" >> ~/.bashrc
fi
#下载turtlebot2i及相关功能包源码并编译
echo -e "\033[42;37mDowloading and building turtlebot2i pkg...\033[0m"
cd ~/turtlebot2i/src
git clone https://github.com/RoboticsWars/Turtlebot2i_KinectV2_SR300.git
cd ~/turtlebot2i
rosdep install --from-paths src --ignore-src -r -y
catkin_make
echo -e "\033[42;37mSetting environment variables...\033[0m"
echo -e "alias goros='source devel/setup.sh'\nexport TURTLEBOT_3D_SENSOR=kinect2\nexport TURTLEBOT_3D_SENSOR2=sr300\nexport TURTLEBOT_BATTERY=None\nexport TURTLEBOT_STACKS=interbotix\nexport TURTLEBOT_ARM=pincher" >> ~/.bashrc
#设置udev规则
sudo usermod -a -G dialout $USER
echo -e "\033[42;37mSetting udev rules...\033[0m"
cd ~/turtlebot2i/
source devel/setup.sh
rospack profile
rosrun kobuki_ftdi create_udev_rules
cd ~/turtlebot2i/src/Turtlebot2i_KinectV2_SR300/turtlebot2i_misc
#echo -e "\033[42;37mPlease modify the serial numbers in 99-turtlebot2i.rules manually.\033[0m"
#udevadm info -a -n /dev/ttyUSB0 | grep '{serial}' | head -n1
#udevadm info -a -n /dev/ttyUSB1 | grep '{serial}' | head -n1
#echo -e "\033[42;37mReplace the ******** with serial numbers.\033[0m"
#gedit 99-turtlebot2i.rules
serial_line1=$(udevadm info -a -n /dev/ttyUSB0 | grep '{serial}' | head -n1)
serial_with_quotation1=${serial_line1##*=}
serial_line2=$(udevadm info -a -n /dev/ttyUSB1 | grep '{serial}' | head -n1)
serial_with_quotation2=${serial_line2##*=}
if [  ${#serial_with_quotation1} -gt ${#serial_with_quotation2} ]
then
  sed -i "s/\"kobuki_\*\*\*\*\*\*\*\*\"/${serial_with_quotation1}/g" ./99-turtlebot2i.rules
  sed -i "s/\"\*\*\*\*\*\*\*\*\"/${serial_with_quotation2}/g" ./99-turtlebot2i.rules
  echo -e "kobuki serial: ${serial_with_quotation1}\narbotix serial: ${serial_with_quotation2}"
else
  sed -i "s/\"kobuki_\*\*\*\*\*\*\*\*\"/${serial_with_quotation2}/g" ./99-turtlebot2i.rules
  sed -i "s/\"\*\*\*\*\*\*\*\*\"/${serial_with_quotation1}/g" ./99-turtlebot2i.rules
  echo -e "kobuki serial: ${serial_with_quotation2}\narbotix serial: ${serial_with_quotation1}"
fi
sudo cp ./99-turtlebot2i.rules /etc/udev/rules.d/
echo -e "\033[42;37mInstallation complete! \033[0m"
