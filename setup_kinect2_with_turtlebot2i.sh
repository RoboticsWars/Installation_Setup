#!/bin/bash -e
echo -e "\033[42;37mMake a backup of ~/turtlebot2i/src/turtlebot2i/turtlebot2i_bringup/launch/3dsensor.launch\033[0m"
cp ~/turtlebot2i/src/turtlebot2i/turtlebot2i_bringu/launch/3dsensor.launch ~/turtlebot2i/src/turtlebot2i/turtlebot2i_bringu/launch/3dsensor.launch.backup
echo -e "\033[42;37mCopying files to related directories...\033[0m"
cp ~/kobuki_interbotix_kinect2/kinect2_bridge/launch/kinect2.launch ~/catkin/src/iai_kinect2/kinect2_bridge/launch/
cp -r ~/kobuki_interbotix_kinect2/turtlebot2i_bringup/. ~/turtlebot2i/src/turtlebot2i/turtlebot2i_bringup/
cp ~/kobuki_interbotix_kinect2/turtlebot2i_description/. ~/turtlebot2i/src/turtlebot2i/turtlebot2i_description/
echo -e "\033[42;37mSetup complete.\033[0m"
