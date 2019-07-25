#!/bin/bash -e
source /opt/ros/kinetic/setup.bash
source /home/turtlebot/catkin_ws/devel/setup.bash
#source /home/turtlebot/turtlebot2i/devel/setup.bash --extend
#tb2i版需要加上这句
export TURTLEBOT_3D_SENSOR=kinect2_rplidar_a2
export TURTLEBOT_BATTERY=None
export TURTLEBOT_STACKS=circle_board
#export ROS_MASTER_URI=http://192.168.0.125:11311
#设置成主机IP
#export ROS_HOSTNAME=192.168.0.125
#设置当前电脑IP，由于自启动需要自己做主机，所以这里也是主机IP
export TURTLEBOT_MAP_FILE=/home/turtlebot/map_20190711.yaml
#地图路径，不能用环境变量，$HOME目录用 /home/用户名 来表示
roslaunch kobuki_x_bringup kobuki_xs_navigation_coffee_bot.launch
