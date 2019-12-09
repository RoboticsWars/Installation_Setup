#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


echo "Please enter your exchange number:"
read exchangenumber


export PYTHONIOENCODING=utf8
#exchangenumber_error;
exchangenumber_error=`curl -s "https://www.imyune.com/circle/index.php?act=exchange&op=index&form_submit=ok&vr_code=$exchangenumber" | \python -c "import sys, json; print json.load(sys.stdin)['error']"`
if [ "${exchangenumber_error}" != "" ]; then
    echo $exchangenumber_error
    exit 1
fi

exchangenumber_vr_indate=`curl -s "https://www.imyune.com/circle/index.php?act=exchange&op=index&form_submit=ok&vr_code=$exchangenumber" | \python -c "import sys, json; print json.load(sys.stdin)['data']['vr_indate']"`
echo $exchangenumber_vr_indate
#!/bin/bash -e
echo -e "\033[42;37mSetting up your sources.list...\033[0m"
#设置ROS源为清华源
#sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
#设置ROS源为中科大源
sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
#获取公钥
echo -e "\033[42;37mSetting up your keys\033[0m"
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
#安装
echo -e "\033[42;37mInstallating ROS-Desktop-Full...\033[0m"
sudo apt update
sudo apt install ros-kinetic-desktop-full -y
#配置依赖项
echo -e "\033[42;37mInitializing rosdep...\033[0m"
apt search ros-kinetic
sudo rosdep init
rosdep update
#环境变量设置
echo -e "\033[42;37mEnvironment setup\033[0m"
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source /opt/ros/kinetic/setup.bash
source ~/.bashrc
#安装编译功能包所需的依赖项
echo -e "\033[42;37mDependencies for building packages\033[0m"
sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential -y
#把当前用户加入dialout用户组
echo -e "\033[42;37mAdd current user to dialout group.\033[0m"
sudo usermod -a -G dialout $USER
#安装turtlebot官方功能包
echo -e "\033[42;37mInstalling turtlebot packages...\033[0m"
sudo apt install ros-kinetic-turtlebot ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-rviz-launchers -y
#安装hector_slam
sudo apt-get install ros-kinetic-hector-slam
echo -e "\033[42;37mROS for turtlebot is installed!\033[0m"
