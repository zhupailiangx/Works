# Build and run OpenCV Perf 

## Linux
```
Download OpenCV source code
cd <source code path>
mkdir build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=ON ..
# opencv_perf_calib3d,opencv_perf_dnn,opencv_perf_features2d,opencv_perf_imgcodes,opencv_perf_objdetect,opencv_perf_photo,opencv_perf_stitching,opencv_perf_video,opencv_perf_videoio,opencv_perf_core,opencv_perf_imgproc
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
cmake --build . --target opencv_perf_core opencv_perf_imgproc --config Release
cd bin/Release
opencv_perf_core.exe
opencv_perf_imgproc.exe
```
## Scripts
### Linux
```
Download build_perf.sh
sh build_perf.sh
cd bin
./opencv_perf_core
./opencv_perf_imgproc
```
### Windows
```
Download build_perf.bat
build_perf.bat
cd bin/Release
opencv_perf_core.exe
opencv_perf_imgproc.exe
```

## Results
### original results
![image](https://github.com/zhupailiangx/Works/assets/120553507/73470fe8-5d84-4425-93ac-49a7bd9f531c)


```
samples - number of collected samples;
min - minimal observed time;
median - median over all collected time measurements;
mean - mean;
stddev - standard deviation.
```

S = 有符号整型 U = 无符号整型 F = 浮点型

CV_8U - 8位无符号整数（0…255）

CV_8S - 8位有符号整数（-128…127）

CV_16U - 16位无符号整数（0…65535）

CV_16S - 16位有符号整数（-32768…32767）

CV_32S - 32位有符号整数（-2147483648…2147483647）

CV_32F - 32位浮点数（-FLT_MAX…FLT_MAX，INF，NAN）

CV_64F - 64位浮点数（-DBL_MAX…DBL_MAX，INF，NAN）


### gtest filter results
```
./opencv_perf_core --gtest_filter=*/0 (1,2,3,4....)
```
![image](https://github.com/zhupailiangx/Works/assets/120553507/aefebc6a-6be0-48a9-8e26-81578dc9a070)

