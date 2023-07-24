#!/bin/bash
git clone -b 4.5.5 https://github.com/opencv/opencv.git
cd opencv
if [ ! -d build ]; then
	mkdir build
fi
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=ON ..
# opencv_perf_calib3d,opencv_perf_dnn,opencv_perf_features2d,opencv_perf_imgcodes,opencv_perf_objdetect,opencv_perf_photo,opencv_perf_stitching,opencv_perf_video,opencv_perf_videoio,opencv_perf_core,opencv_perf_imgproc
make -j$(nproc) opencv_perf_core opencv_perf_imgproc
