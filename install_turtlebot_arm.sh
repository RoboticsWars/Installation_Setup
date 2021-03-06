#!/bin/bash -e
#安装arbotix_ros和turtlebot_arm功能包
echo -e "\033[42;37mInstallating arbotix_ros and turtlebot_arm...\033[0m"
sudo apt install ros-$ROS_DISTRO-moveit ros-$ROS_DISTRO-moveit-plugins ros-$ROS_DISTRO-moveit-planners -y
source /opt/ros/$ROS_DISTRO/setup.bash
cd ~/
if [ ! -d "turtlebot_arm_ws/src" ]; then
  echo -e "\033[42;37mCreating work space for turtlebot_arm...\033[0m"
  mkdir -p ~/turtlebot_arm_ws/src
  echo "source ~/turtlebot_arm_ws/devel/setup.bash --extend" >> ~/.bashrc
fi
cd ~/turtlebot_arm_ws/src/
catkin_init_workspace
cd ~/turtlebot_arm_ws/
catkin_make
source ~/.bashrc
cd ~/turtlebot_arm_ws/src/
git clone -b turtlebot2i https://github.com/Interbotix/arbotix_ros.git
git clone https://github.com/turtlebot/turtlebot_arm.git
cd ..
rosdep install --from-paths src --ignore-src -r -y
catkin_make
cd ~/
if [ ! -d "Turtlebot2_Kinect2" ]; then
  echo -e "\033[42;37mDowloading https://github.com/RoboticsWars/Turtlebot2_Kinect2.git ...\033[0m"
  git clone https://github.com/RoboticsWars/Turtlebot2_Kinect2.git
else
  cd Turtlebot2_Kinect2
  git pull
fi
mkdir ~/turtlebot_arm_ws/src/turtlebot_arm/turtlebot_arm_moveit_demos/scripts/
cp ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot_arm/turtlebot_arm_moveit_demos/scripts/pick_and_place_pincher.py ~/turtlebot_arm_ws/src/turtlebot_arm/turtlebot_arm_moveit_demos/scripts/
#设置udev规则
echo -e "\033[42;37mSetting udev rules...\033[0m"
sudo usermod -a -G dialout $USER
cd ~/
touch 99-arbotix-m.rules
echo -e "#Use this command:\n#	udevadm info -a -n /dev/ttyUSB0 | grep '{serial}' | head -n1\n#To determine serial numbers and fill in ******** for udev rules below:\nSUBSYSTEM==\"tty\", ATTRS{idVendor}==\"0403\", ATTRS{idProduct}==\"6001\", ATTRS{serial}==\"********\", SYMLINK+=\"arbotix\"" >> ~/99-arbotix-m.rules
serial_line=$(udevadm info -a -n /dev/ttyUSB0 | grep '{serial}' | head -n1)
serial_with_quotation=${serial_line##*=}
echo -e "arbotix serial: ${serial_with_quotation}"
sed -i "s/\"\*\*\*\*\*\*\*\*\"/${serial_with_quotation}/g" ~/99-arbotix-m.rules
sudo mv ~/99-arbotix-m.rules /etc/udev/rules.d/
echo "Restarting udev"
sudo service udev reload
sudo service udev restart
echo "udev started"
#修改pincher_arm.yaml配置文件
echo -e "\033[42;37mModifying pincher_arm.yaml...\033[0m"
cd ~/turtlebot_arm_ws/src/turtlebot_arm/turtlebot_arm_bringup/config/
sed -i "s/ttyUSB0/arbotix/g" pincher_arm.yaml
#添加pincher为环境变量
echo -e "\033[42;37mAdding pincher as an environment variable...\033[0m"
cd ~
echo "export TURTLEBOT_ARM1=pincher" >> ~/.bashrc
echo -e "\033[42;37mInstallation complete! \033[0m"
