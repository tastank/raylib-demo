#!/bin/sh

# Install raylib and its dependencies
PWD=`pwd`
# the libraries after the # are needed only on desktop platform installs
sudo apt install make git vim cmake libgles2-mesa-dev libgbm-dev libdrm-dev -y # libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev
git clone https://github.com/raysan5/raylib.git
cd raylib
# choose one depending on environment
#cmake -DPLATFORM=Desktop -DOPENGL_VERSION=2.1 -DPLATFORM_CPP=PLATFORM_DESKTOP -DGRAPHICS=GRAPHICS_API_OPENGL_21 .
cmake -DPLATFORM=DRM -DOPENGL_VERSION="ES 2.0" -DPLATFORM_CPP=PLATFORM_DRM -DGRAPHICS=GRAPHICS_API_OPENGL_ES2 .
make
sudo make install

# Build the demo program
cd $PWD
make

# Make it run at boot time
SERVICE_FILE=/lib/systemd/system/cluster.service
touch $SERVICE_FILE
echo "[Unit]" > $SERVICE_FILE
echo "Description=Digital Gauge Cluster" >> $SERVICE_FILE
echo "After=multi-user.target\n" >> $SERVICE_FILE
echo "[Service]" >> $SERVICE_FILE
echo "ExecStart=$PWD/bin/$EXEC_FILE\n" >> $SERVICE_FILE
echo "[Install]" >> $SERVICE_FILE
echo "WantedBy=multi-user.target" >> $SERVICE_FILE
