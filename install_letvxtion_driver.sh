#!/bin/bash -e
#安装奥比中光Astra深度相机驱动
echo -e "\033[42;37mInstalling Astra driver ...\033[0m"
cd ~/Downloads/
wget http://dl.orbbec3d.com/dist/openni2/OpenNI_2.3.0.55.zip
unzip OpenNI_2.3.0.55.zip
cd OpenNI_2.3.0.55/Linux/OpenNI-Linux-x64-2.3.0.55/
chmod a+x install.sh
sudo ./install.sh
source OpenNIDevEnvironment
cd Samples/SimpleViewer
make
