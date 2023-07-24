git clone -b 4.5.5 https://github.com/opencv/opencv.git
cd opencv
if not exist build\ (
    mkdir build
)
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=ON ..
@REM  opencv_perf_calib3d,opencv_perf_dnn,opencv_perf_features2d,opencv_perf_imgcodes,opencv_perf_objdetect,opencv_perf_photo,opencv_perf_stitching,opencv_perf_video,opencv_perf_videoio,opencv_perf_core,opencv_perf_imgproc
cmake --build . --target opencv_perf_core opencv_perf_imgproc  --config Release
cd bin/Release
opencv_perf_core.exe
opencv_perf_imgproc.exe
