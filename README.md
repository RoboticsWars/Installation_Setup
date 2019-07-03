# Installation_Setup
安装ROS和配置驱动用的脚本文件
* install_ros.sh 安装ROS Kinetic和turtlebot2相关的功能包（其他脚本文件均不包括turtlebot2功能包的安装）
* install_kinect2_intel.sh 安装kinect2的驱动（Intel显卡的电脑）
* install_kinect2_nvidia.sh 安装kinect2的驱动（Nvidia jetson开发板）
* install_kinect2_ros.sh 安装kinect2的ROS功能包（先需要安装kinect2驱动）
* inatall_astra.sh 安装astra的驱动和ROS功能包
* install_turtlebot2i_kinect2.sh 安装turtlebot2i配kinect2的ROS功能包，不包括kinect2的安装
* install_turtlebot2i_astra.sh 安装turtlebot2i配astra的ROS功能包，不包括astra的安装
* setup_kinect2_with_turtlebot2.sh 设置kinect2与turtlebot2关联的文件（先需要安装kinect2的ROS功能包）
* setup_kinect2_with_turtlebot2i.sh 设置kinect2与turtlebot2i关联的文件（原版turtlebot2i需要运行此脚本）
* install_rchomeedu.sh 安装robocup@home education相关软件
* install_arduinoide_and_dynamanager.sh 安装arduinoIDE和DynaManager（用来烧录arbotix-M的固件和设置Dynamixel舵机的ID）
* install_turtlebot_arm.sh 安装arbotix_ros和turtlebot_arm功能包
