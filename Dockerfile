FROM debian:stable-slim

ENV NODE_VERSION=16

# Install tools
RUN apt-get update && apt-get install -y git wget curl vim software-properties-common

# Install Node 16!
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - 
RUN apt-get install nodejs 

#  Install OpenCV
## Requirements
RUN apt install -y build-essential cmake pkg-config libgtk-3-dev  libavcodec-dev libavformat-dev libswscale-dev libv4l-dev  libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev  gfortran openexr libatlas-base-dev python3-dev python3-numpy libtbb2 libtbb-dev libdc1394-22-dev

## Cloning the sources
RUN mkdir opencv_git && cd opencv_git &&  git clone https://github.com/opencv/opencv.git && git clone https://github.com/opencv/opencv_contrib.git

## Compiling ...
RUN cd /opencv_git/opencv && mkdir cvbuild && cd cvbuild && \
cmake -D CMAKE_BUILD_TYPE=RELEASE \ -D CMAKE_INSTALL_PREFIX=/usr/local \ -D INSTALL_C_EXAMPLES=ON \ -D INSTALL_PYTHON_EXAMPLES=ON \ -D OPENCV_GENERATE_PKGCONFIG=ON \ -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/module \ -D BUILD_EXAMPLES=ON ..

## Make
RUN cd /opencv_git/opencv/cvbuild && make -j1

## Make install
RUN cd /opencv_git/opencv/cvbuild && make install

# THE ENV SECTION
ENV OPENCV4NODEJS_DISABLE_AUTOBUILD=1
ENV OPENCV_INCLUDE_DIR=/usr/local/include/opencv4/
ENV OPENCV_LIB_DIR=/usr/local/lib/
ENV OPENCV_BIN_DIR=/usr/local/bin/