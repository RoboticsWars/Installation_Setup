# Installation_Setup

------------安装ROS和配置驱动用的脚本文件------------------

* install_ros.sh 安装ROS Kinetic和turtlebot2相关的功能包（其他脚本文件均不包括turtlebot2功能包的安装）
* install_kinect2_intel.sh 安装kinect2的驱动（Intel显卡的电脑）
* install_kinect2_nvidia.sh 安装kinect2的驱动（Nvidia jetson开发板）
* install_kinect2_ros.sh 安装kinect2的ROS功能包（先需要安装kinect2驱动）
* inatall_astra.sh 安装astra的驱动和ROS功能包
* inatall_astra_driver.sh 安装astra的驱动（如果前一个脚本执行后没能成功安装astra驱动需要运行此脚本）
* install_turtlebot2i_kinect2.sh 安装turtlebot2i配kinect2的ROS功能包，不包括kinect2的安装
* install_turtlebot2i_astra.sh 安装turtlebot2i配astra的ROS功能包，不包括astra的安装
* setup_kinect2_with_turtlebot2.sh 设置kinect2与turtlebot2关联的文件（先需要安装kinect2的ROS功能包）
* setup_kinect2_with_turtlebot2i.sh 设置kinect2与turtlebot2i关联的文件（原版turtlebot2i需要运行此脚本）
* install_rchomeedu.sh 安装robocup@home education相关软件
* install_arduinoide_and_dynamanager.sh 安装arduinoIDE和DynaManager（用来烧录arbotix-M的固件和设置Dynamixel舵机的ID）
* install_turtlebot_arm.sh 安装arbotix_ros和turtlebot_arm功能包
* setup_kobuki_xs_with_kinect2.sh 设置kobuki_xs配kinect2的参数
* kobuki_xs_auto_start.sh 自启动脚本
* setup_kobuki_xs_with_kinect2_paclidar.sh 设置kobuki_xs配kinect2和paclidar的参数
* setup_kobuki_xs_with_kinect2_rplidara2_turtlebot2.sh 设置turtlebot2(kobuki_xs)配kinect2和rplidar a2的参数
* setup_kobuki_xs_with_kinect2_rplidara2.sh 设置kobuki_xs配kinect2和rplidar a2的参数
* setup_kobuki_xs_with_kinect2_rplidars1.sh 设置kobuki_xs配kinect2和rplidar s1的参数
* install_kobuki_xs_tb2i_with_kinect2.sh 安装tb2i版kobuki_xs

----------------------环境传感器设置---------------------

* 根据自己的传感器将环境变量[TURTLEBOT_3D_SENSOR]修改为对应的传感器类型，并将其添加至～/.bashrc文件中：
* 传感器为kinect2+pac激光雷达：          export TURTLEBOT_3D_SENSOR=kinect2_paclidar
* 为kinect2+思岚激光雷达A2：        export TURTLEBOT_3D_SENSOR=kinect2_rplidar_a2
* 传感器为pac激光雷达：                  export TURTLEBOT_3D_SENSOR=paclidar
* 传感器为思岚激光雷达A2：                export TURTLEBOT_3D_SENSOR=rplidar_a2
* 传感器为LetvXtion或奥比中光RGB-D摄像头： export TURTLEBOT_3D_SENSOR=astra
* 例如，当前传感器类型为kinct2+pac雷达，则将这条语句 export TURTLEBOT_3D_SENSOR=kinect2_paclidar 添加至[～/.bashrc]文件的末尾。
* 注意：如果该文件中已有该语句，则将先前的语句注释掉(在语句前加 # 即可)
