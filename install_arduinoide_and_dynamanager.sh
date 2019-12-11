#!/bin/bash -e
#安装java运行时环境(为8u211版本，如官方有更新请自行更改链接)
echo -e "\033[42;37mInstalling jre...\033[0m"
cd ~/Downloads/
wget -O jre-8u211-linux-x64.tar.gz https://javadl.oracle.com/webapps/download/AutoDL?BundleId=238719_478a62b7d4e34b78b671c754eaaf38ab
tar -zxvf jre-8u211-linux-x64.tar.gz
sudo mkdir /usr/lib/java
sudo mv jre1.8.0_211 /usr/lib/java/
echo -e "export JAVA_HOME=/usr/lib/java/jre1.8.0_211" >> ~/.bashrc
export JAVA_HOME=/usr/lib/java/jre1.8.0_211
echo -e "export PATH=$PATH:$JAVA_HOME/bin\nexport CLASSPATH=.:$JAVA_HOME/lib" >> ~/.bashrc
source ~/.bashrc
sudo update-alternatives --install /usr/bin/java java /usr/lib/java/jre1.8.0_211/bin/java 300
java -version
#安装ArduinoIDE 1.0.6
echo -e "\033[42;37mInstalling ArduinoIDE 1.0.6 ...\033[0m"
cd ~/
if [ ! -d "tools" ]; then
  mkdir ~/tools
fi
if [ ! -d "Arduino" ]; then
  mkdir ~/Arduino
fi
cd ~/tools/
wget http://file.ncnynl.com/ros/arduino-1.0.6-linux64.tgz
tar -zxvf arduino-1.0.6-linux64.tgz
#下载arbotix库
echo -e "\033[42;37mDownloading arbotix files...\033[0m"
git clone https://github.com/Interbotix/arbotix.git
cp -r arbotix/hardware/. arduino-1.0.6/hardware
cp -r arbotix/libraries/. arduino-1.0.6/libraries
cp -r arbotix/Arb* ~/Arduino
#下载DynaManager
echo -e "\033[42;37mDownloading DynaManager...\033[0m"
cd ~/Downloads/
wget https://github.com/Interbotix/dynaManager/releases/download/1.3/dynamanger_all_no_java.zip
unzip dynamanger_all_no_java.zip
#自行打开arduinoIDE，然后修改preferences中的Sketchbook location为/home/turtlebot/Arduino/，然后重启arduinoIDE，就可以看到arbotix提供的例程了
echo -e "\033[42;37mRun arduinoIDE and change the Sketchbook location to /home/turtlebot/Arduino/ then restart arduinoIDE. \033[0m"
