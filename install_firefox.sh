#!/bin/bash -e
#安装java运行时环境
echo -e "\033[42;37mInstalling firefox ...\033[0m"
sudo rm -r /usr/bin/firefox
#sudo mv /usr/bin/firefox /usr/bin/firefox-old
cd /opt/
sudo wget http://www.imyune.com/file/firefox-71.0a1.en-US.linux-x86_64.tar.bz2
sudo tar -xjvf firefox-71.0a1.en-US.linux-x86_64.tar.bz2
sudo ln -s /opt/firefox/firefox /usr/bin/firefox

#自行打开arduinoIDE，然后修改preferences中的Sketchbook location为/home/turtlebot/Arduino/，然后重启arduinoIDE，就可以看到arbotix提供的例程了
echo -e "\033[42;37mRun Installing done \033[0m"
