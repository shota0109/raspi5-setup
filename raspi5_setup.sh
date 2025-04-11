#更新
apt update && apt upgrade -y

#アプリケーションのインストール
#VScode
apt install software-properties-common apt-transport-https wget -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sh -c 'echo "deb [arch=arm64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt install code -y

#Chromium
apt install -y chromium-browser

#Terminator
apt install -y terminator

#依存関係
apt install -y build-essential cmake git libbullet-dev libpython3-dev python3-flake8 python3-pytest-cov python3-setuptools wget

#ROS2Humble
apt-get install -y curl
apt update
apt install -y ros-humble-desktop
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
apt install -y python3-colcon-common-extensions
apt install -y python3-rosdep2
rosdep update
apt-get install -y ros-humble-cv-bridge libncurses5-dev libncursesw5-dev ros-humble-raspimouse ros-humble-smach-ros python3-vcstool
apt install ros-humble-tf-transformations ros-humble-nav2* -y

mkdir -p ~/argos_ws/src
cd ~/argos_ws
rosdep update
source /opt/ros/humble/setup.bash
rosdep install --from-paths src --ignore-src -r -y
colcon build
source /opt/ros/humble/setup.bash

#OpenCV
apt remove -y python3-opencv
apt install -y python3-pip
pip install --upgrade pip
pip3 install scikit-build Cython wheel transforms3d
pip3 install opencv-contrib-python==4.8.1.78
pip3 install numpy==1.23.5

#リポジトリのクローン
cd ~/raspi5_setup
./update.sh

cd ~/argos_ws
rosdep install --from-paths src --ignore-src -r -y
colcon build
source install/setup.bash

#カメラに権限を付与
usermod -a -G video root

#ディスプレイのセキュリティを無効化
xhost +
