#!/bin/bash
if [! -d build ]; then
	mkdir build
fi
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=ON ..
make -j$(nproc) opencv_perf_core opencv_perf_imgproc
cd bin
./opencv_perf_core
./opencv_perf_imgproc 

