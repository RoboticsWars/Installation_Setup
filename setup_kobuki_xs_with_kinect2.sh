#!/bin/bash -e
#下载kinect2相关的配置文件
source /opt/ros/kinetic/setup.bash
cd ~/
if [ ! -d "Turtlebot2_Kinect2" ]; then
  echo -e "\033[42;37mDowloading https://github.com/RoboticsWars/Turtlebot2_Kinect2.git ...\033[0m"
  git clone https://github.com/RoboticsWars/Turtlebot2_Kinect2.git
else
  cd Turtlebot2_Kinect2
  git pull
fi
#复制文件
echo -e "\033[42;37mCopying files to related directories...\033[0m"
sudo cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot_description/. /opt/ros/kinetic/share/turtlebot_description/
sudo cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot_navigation/launch/. /opt/ros/kinetic/share/turtlebot_navigation/launch/
cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/iai_kinect2/kinect2_bridge/launch/kinect2_laser.launch ~/catkin_ws/src/iai_kinect2/kinect2_bridge/launch/
sudo cp /opt/ros/kinetic/share/turtlebot_navigation/param/costmap_common_params.yaml /opt/ros/kinetic/share/turtlebot_navigation/param/costmap_common_params.yaml.backup
sudo cp /opt/ros/kinetic/share/turtlebot_navigation/param/dwa_local_planner_params.yaml /opt/ros/kinetic/share/turtlebot_navigation/param/dwa_local_planner_params.yaml.backup
sudo cp ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot_navigation/param/* /opt/ros/kinetic/share/turtlebot_navigation/param/
cd ~/
if [ ! -d "catkin_ws" ]; then
  echo -e "\033[42;37mCreating work space named catkin_ws...\033[0m"
  mkdir -p ~/catkin_ws/src
  echo "source ~/catkin_ws/devel/setup.bash --extend" >> ~/.bashrc
fi
cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/kobuki_x_description/ ~/catkin_ws/src
cd ~/catkin_ws
rosdep install --from-paths src --ignore-src -r -y
catkin_make
rospack profile
echo -e "export TURTLEBOT_3D_SENSOR=kinect2\nexport TURTLEBOT_BATTERY=None\nexport TURTLEBOT_STACKS=circle_board" >> ~/.bashrc
source ~/.bashrc
#修改参数并编译
echo -e "\033[42;37mSetting up parameters and compiling source code...\033[0m"
cd ~/
git clone -b kinetic https://github.com/rcwind/kicc100t_ros_driver.git
cd ~/kicc100t_ros_driver/src/kobuki_driver/src/driver
sed -i "s/0.226/0.315/g" diff_drive.cpp
sed -i "s/0.031/0.0625/g" diff_drive.cpp
sed -i "s/0.004197185/0.001570796/g" diff_drive.cpp
cd ~/kicc100t_ros_driver
make cmake
cd ~/kicc100t_ros_driver/out/x86_32/debug/build
make
#配置udev规则
cd ~/
touch 99-kobuki_x.rules
echo -e "SUBSYSTEM==\"tty\", ATTRS{idVendor}==\"10c4\", ATTRS{idProduct}==\"ea60\", SYMLINK+=\"kobuki\"" >> ~/99-kobuki_x.rules
sudo mv ~/99-kobuki_x.rules /etc/udev/rules.d/
echo "Restarting udev"
sudo service udev reload
sudo service udev restart
echo "udev started"
echo -e "\033[42;37mSetup complete! \033[0m"
