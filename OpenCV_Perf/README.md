# Build and run OpenCV Perf 

## Linux
```
Download OpenCV source code
cd <source code path>
mkdir build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=ON ..
# opencv_perfcalib3d,opencv_perf_dnn,opencv_perf_features2d,opencv_perf_imgcodes,opencv_perf_objdetect,opencv_perf_photo,opencv_perf_stitching,opencv_perf_video,opencv_perf_videoio,opencv_perf_core,opencv_perf_imgproc
make -j$(nproc) opencv_perf_core opencv_perf_imgproc
cd bin
./opencv_perf_core
./opencv_perf_imgproc
```


## Windows 
```
Download OpenCV source code
open cmd
cd opencv
mkdir build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=ON ..
cmake --build . --target opencv_perf_core opencv_perf_imgproc
cd bin/Release
opencv_perf_core.exe
opencv_perf_imgproc.exe
```
## Scripts
### Linux
```
Download build_perf.sh
cd OpenCV source code
sh build_perf.sh
```
### Windows
```
Download build_perf.bat
cd cd OpenCV source code
build_perf.bat
```

## Result
![image](https://github.com/zhupailiangx/Works/assets/120553507/73470fe8-5d84-4425-93ac-49a7bd9f531c)


```
samples - number of collected samples;
min - minimal observed time;
median - median over all collected time measurements;
mean - mean;
stddev - standard deviation.
```
