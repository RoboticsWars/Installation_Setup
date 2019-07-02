#安装arbotix_ros和turtlebot_arm功能包
echo -e "\033[42;37mInstallating arbotix_ros and turtlebot_arm...\033[0m"
sudo apt install ros-kinetic-moveit-* -y
source /opt/ros/kinetic/setup.bash
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
echo -e "\033[42;37mInstallation complete! \033[0m"
