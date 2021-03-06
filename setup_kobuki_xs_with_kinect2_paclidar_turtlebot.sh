#!/bin/bash -e
#下载kinect2相关的配置文件
source /opt/ros/kinetic/setup.bash
echo -e "\033[42;37mDowloading setup files...\033[0m"
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
cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/iai_kinect2/kinect2_bridge/launch/. ~/catkin_ws/src/iai_kinect2/kinect2_bridge/launch/
sudo cp /opt/ros/kinetic/share/turtlebot_navigation/param/costmap_common_params.yaml /opt/ros/kinetic/share/turtlebot_navigation/param/costmap_common_params.yaml.backup
sudo cp /opt/ros/kinetic/share/turtlebot_navigation/param/dwa_local_planner_params.yaml /opt/ros/kinetic/share/turtlebot_navigation/param/dwa_local_planner_params.yaml.backup
sudo cp ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot_navigation/param/* /opt/ros/kinetic/share/turtlebot_navigation/param/
#sudo cp ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot_bringup/launch/* /opt/ros/kinetic/share/turtlebot_bringup/launch/
sudo cp /opt/ros/kinetic/share/turtlebot_rviz_launchers/rviz/navigation.rviz /opt/ros/kinetic/share/turtlebot_rviz_launchers/rviz/navigation.rviz.backup
sudo cp ~/Turtlebot2_Kinect2/TB2+Kinect2/turtlebot_rviz_launchers/rviz/navigation.rviz /opt/ros/kinetic/share/turtlebot_rviz_launchers/rviz
cd ~/
if [ ! -d "catkin_ws" ]; then
  echo -e "\033[42;37mCreating work space named catkin_ws...\033[0m"
  mkdir -p ~/catkin_ws/src
  echo "source ~/catkin_ws/devel/setup.bash --extend" >> ~/.bashrc
fi


if [ ! -d "catkin_ws/src/kobuki_x_project" ]; then
  echo -e "\033[42;37mDowloading kobuki_x_project metapackage...\033[0m"
  cd ~/catkin_ws/src/
  git clone https://github.com/RoboticsWars/kobuki_x_project.git
else
  cd ~/catkin_ws/src/kobuki_x_project/
  git pull
fi

if [ ! -d "catkin_ws/src/slam_gmapping" ]; then
  echo -e "\033[42;37mDowloading slam_gmapping metapackage...\033[0m"
  cd ~/catkin_ws/src/
  git clone https://github.com/ros-perception/slam_gmapping.git
else
  cd ~/catkin_ws/src/slam_gmapping/
  git pull
fi

if [ ! -d "catkin_ws/src/openslam_gmapping" ]; then
  echo -e "\033[42;37mDowloading openslam_gmapping metapackage...\033[0m"
  cd ~/catkin_ws/src/
  git clone https://github.com/RoboticsWars/openslam_gmapping.git
else
  cd ~/catkin_ws/src/openslam_gmapping/
  git pull
fi
#安装PACLidarRosDriver功能包
echo -e "\033[42;37mInstalling PACLidarRosDriver...\033[0m"
if [ ! -d "catkin_ws/src/PACLidarRosDriver" ]; then
  echo -e "\033[42;37mDowloading PACLidarRosDriver metapackage...\033[0m"
  cd ~/catkin_ws/src/
  git clone https://github.com/RoboticsWars/PACLidarRosDriver.git
else
  cd ~/catkin_ws/src/PACLidarRosDriver/
  git pull
fi
#cp -r ~/Turtlebot2_Kinect2/TB2+Kinect2/kobuki_x_description/ ~/catkin_ws/src

cd ~/catkin_ws
rosdep install --from-paths src --ignore-src -r -y
catkin_make
rospack profile
echo -e "export TURTLEBOT_3D_SENSOR=kinect2_paclidar\nexport TURTLEBOT_BATTERY=None\nexport TURTLEBOT_STACKS=circle_board" >> ~/.bashrc
source ~/.bashrc

#修改参数并编译


#安装pointcloud_to_laserscan功能包
echo -e "\033[42;37mInstalling pointcloud_to_laserscan...\033[0m"
sudo apt install ros-$ROS_DISTRO-pointcloud-to-laserscan -y
#安装laser_filters功能包
echo -e "\033[42;37mInstalling laser_filters...\033[0m"
sudo apt install ros-$ROS_DISTRO-laser-filters -y
#安装robot_pose_publisher功能包
echo -e "\033[42;37mInstalling robot_pose_publisher...\033[0m"
sudo apt install ros-$ROS_DISTRO-robot-pose-publisher -y
#安装rosbridge_suite
echo -e "\033[42;37mInstalling rosbridge_suite...\033[0m"
sudo apt install ros-kinetic-rosbridge-suite -y
#配置udev规则
echo -e "\033[42;37mCreating rules file for kobuki_x and rplidar...\033[0m"
cd ~/
touch 99-kobuki_x.rules
echo -e "SUBSYSTEM==\"tty\", KERNELS==\"*-*.4\", ATTRS{idVendor}==\"10c4\", ATTRS{idProduct}==\"ea60\", SYMLINK+=\"kobuki\"" >> ~/99-kobuki_x.rules
#touch 99-rplidara2.rules
#echo -e "SUBSYSTEM==\"tty\", KERNELS==\"*-*.3\", ATTRS{idVendor}==\"10c4\", ATTRS{idProduct}==\"ea60\", SYMLINK+=\"rplidara2\"" >> ~/99-rplidara2.rules
sudo mv ~/*.rules /etc/udev/rules.d/
sudo usermod -a -G dialout $USER
echo "Restarting udev"
sudo service udev reload
sudo service udev restart
echo "udev started"
echo -e "\033[42;37mSetup complete! \033[0m"
