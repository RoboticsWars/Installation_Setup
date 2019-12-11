#!/bin/bash -e
echo -e "\033[42;37m**************Start**************\033[0m"
cd /home
if [ ! -d "/home/sblive" ]; then
    echo -e "\033[42;37mCreating sblive folder...\033[0m"
    sudo mkdir -p /home/sblive
else
    echo -e "\033[42;37mCleaning sblive folder...\033[0m"
    cd /home
    sudo rm sblive -rf
    sudo mkdir -p /home/sblive
fi

echo -e "\033[42;37mExtravting sblive system...\033[0m"
cd /home
sudo tar -xf /home/systemback_live_*.sblive -C sblive

echo -e "\033[42;37mSetting sblive system...\033[0m"
cd /home
sudo mv sblive/syslinux/syslinux.cfg sblive/syslinux/isolinux.cfg
sudo mv sblive/syslinux sblive/isolinux

echo -e "\033[42;37mCheacking tools...\033[0m"
cd ~
if [ ! -f "/opt/schily/bin/mkisofs" ]; then
    echo -e "\033[42;37mDownloading cdrtools-3.02...\033[0m"
    cd ~/Downloads
    sudo apt install aria2
    aria2c -s 10 https://nchc.dl.sourceforge.net/project/cdrtools/alpha/cdrtools-3.02a07.tar.gz
    tar -xzvf cdrtools-3.02a07.tar.gz
    cd cdrtools-3.02
    make
    sudo make install
fi

echo -e "\033[42;37mCreating sblive.iso file...\033[0m"
cd /home
sudo /opt/schily/bin/mkisofs -iso-level 3 -r -V sblive -cache-inodes -J -l -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -c isolinux/boot.cat -o sblive.iso sblive

echo -e "\033[42;37mCleaning useless sblive file...\033[0m"
cd /home
sudo rm sblive systemback_live_*.sblive -rf

echo -e "\033[42;37m**************Done**************\033[0m"
