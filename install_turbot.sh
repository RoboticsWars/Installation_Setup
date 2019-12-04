#!/bin/bash -e
cd ~
source /opt/ros/kinetic/setup.bash
echo -e "\033[42;37mInstalling turbot packages...\033[0m"
#创建turbot工作区
if [ ! -d "turbot/src" ]; then
    echo -e "\033[42;37mCreating work space for turbot...\033[0m"
    mkdir -p ~/turbot/src
    echo "source ~/turbot/devel/setup.bash --extend" >> ~/.bashrc
fi

#下载turbot及相关功能包源码并编译
echo -e "\033[42;37mDowloading and building turbot pkg...\033[0m"
cd ~/turbot/src
git clone https://github.com/ncnynl/turbot.git
cd ~/turbot
rosdep install --from-paths src --ignore-src -r -y
catkin_make

#下载turbot_app及相关功能包源码并编译
echo -e "\033[42;37mDowloading and building turbot_apps pkg...\033[0m"
cd ~/turbot/src
git clone https://github.com/ncnynl/turtlebot_apps
cd ~/turbot
rosdep install --from-paths src --ignore-src -r -y
catkin_make

echo -e "\033[42;37mSetup complete! \033[0m"