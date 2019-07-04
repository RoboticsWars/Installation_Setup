#!/bin/bash -e
#安装其他依赖
echo -e "\033[42;37mInstalling dependences for kinect2...\033[0m"
sudo apt install build-essential cmake pkg-config libturbojpeg libjpeg-turbo8-dev mesa-common-dev freeglut3-dev libxrandr-dev libxi-dev -y
#下载libfreenect2驱动
echo -e "\033[42;37mDownloading libfreenect2...\033[0m"
cd ~
git clone https://github.com/OpenKinect/libfreenect2.git
cd libfreenect2
cd depends; ./download_debs_trusty.sh
#安装libusb
echo -e "\033[42;37mInstalling libusb...\033[0m"
sudo dpkg -i debs/libusb*deb
#安装 TurboJPEG
echo -e "\033[42;37mInstalling TurboJPEG...\033[0m"
sudo apt install libturbojpeg libjpeg-turbo8-dev -y
#安装GLFW3
echo -e "\033[42;37mInstalling GLFW3...\033[0m"
sudo apt install libglfw3-dev -y
#安装OpenGL的支持库
echo -e "\033[42;37mInstalling OpenGL libraries...\033[0m"
sudo dpkg -i debs/libglfw3*deb; sudo apt install -f; sudo apt install libgl1-mesa-dri-lts-vivid -y
#安装OpenCL的支持库
echo -e "\033[42;37mInstalling OpenCL libraries...\033[0m"
sudo apt install beignet beignet-dev -y
#安装VAAPI
echo -e "\033[42;37mInstalling VAAPI...\033[0m"
sudo apt install libva-dev libjpeg-dev -y
#安装OpenNI2
echo -e "\033[42;37mInstalling OpenNI2...\033[0m"
sudo apt install libopenni2-dev -y
#编译libfreenect2
echo -e "\033[42;37mCompiling libfreenect2...\033[0m"
cd ~/libfreenect2
mkdir build && cd build
cmake ..
make
sudo make install
#建立别名，设置usb规则
echo -e "\033[42;37mSetting up udev rules...\033[0m"
cd ~/libfreenect2
sudo cp platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/
#安装完毕，可以进行驱动测试。运行~/libfreenect2/build/bin/Protonect.
echo -e "\033[42;37mNow you can test your kinect2 device. Run the program ~/libfreenect2/build/bin/Protonect. \033[0m"
