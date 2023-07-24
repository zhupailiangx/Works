#!/bin/bash
git clone -b 4.5.5 https://github.com/opencv/opencv.git
cd opencv
if [ ! -d build ]; then
	mkdir build
fi
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=ON ..
make -j$(nproc) opencv_perf_core opencv_perf_imgproc
cd bin
./opencv_perf_core
./opencv_perf_imgproc 

