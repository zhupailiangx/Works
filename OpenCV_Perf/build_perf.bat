if not exist build\ (
    mkdir build
)
cd build
cmake -DBUILD_PERF_TESTS=ON ..
cmake --build . --target opencv_perf_core opencv_perf_imgproc  --config Release
