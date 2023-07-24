if not exist build\ (
    mkdir build
)
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=ON ..
cmake --build . --target opencv_perf_core opencv_perf_imgproc  --config Release
cd bin/Release
./opencv_perf_core.exe
./opencv_perf_imgproc.exe
