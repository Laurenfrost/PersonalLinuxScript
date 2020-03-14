#!/bin/sh
##build ffmpeg before this script## 

##gtk2.0 should be installed for namedwindow.
#apt install cmake libgtk2.0-dev pkg-config python python-numpy python3-dev python-scipy

##"Qt5_DIR" lead to where Qt5 installed.
#export Qt5_DIR=/opt/Qt5.1.1/5.1.1/gcc_64

rm -rf build
mkdir build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_PNG=ON \
    -DBUILD_TIFF=OFF \
    -DBUILD_TBB=OFF \
    -DBUILD_JPEG=ON \
    -DBUILD_JASPER=OFF \
    -DBUILD_ZLIB=ON \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_opencv_java=OFF \
    -DBUILD_opencv_python2=ON \
    -DBUILD_opencv_python3=ON \
    -DENABLE_PRECOMPILED_HEADERS=OFF \
    -DWITH_OPENCL=ON \
    -DWITH_OPENMP=ON \
    -DWITH_FFMPEG=ON \
    -DWITH_GSTREAMER=OFF \
    -DWITH_GSTREAMER_0_10=OFF \
    -DWITH_CUDA=OFF \
#   -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
    -DWITH_QT=ON \
    -DWITH_OPENGL=ON \
    -DWITH_GTK=ON \
    -DWITH_VTK=OFF \
    -DWITH_TBB=OFF \
    -DWITH_1394=OFF \
    -DWITH_OPENEXR=OFF \
    -DINSTALL_C_EXAMPLES=ON \
    -DINSTALL_PYTHON_EXAMPLES=ON \
    -DINSTALL_TESTS=OFF \
    -DOPENCV_EXTRA_MODULES_PATH=/home/dedicatus/Downloads/opencv_contrib-4.2.0/modules \
#turn "OPENCV_GENERATE_PKGCONFIG" on to generate opencv.pc
    -DOPENCV_GENERATE_PKGCONFIG=ON \
    ..
