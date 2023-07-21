# Build and run OpenCV Perf 

## Linux
```
download opencv source code
cd <source code path>
mkdir build
cmake ..
# opencv_perfcalib3d,opencv_perf_dnn,opencv_perf_features2d,opencv_perf_imgcodes,opencv_perf_objdetect,opencv_perf_photo,opencv_perf_stitching,opencv_perf_video,opencv_perf_videoio,opencv_perf_core,opencv_perf_imgproc
make -j8 opencv_perf_core opencv_perf_imgproc
cd bin
./opencv_perf_core or ./opencv_perf_imgproc
```
{   perf_max_outliers           |8        |percent of allowed outliers}"<br>
        "{   perf_min_samples            |10       |minimal required numer of samples}"<br>
        "{   perf_force_samples          |100      |force set maximum number of samples for all tests}"<br>
        "{   perf_seed                   |809564   |seed for random numbers generator}"
```
./opencv_perf_core -perf_min_samples=100 -perf_force_samples=100 (or any other number)
```
## Windows 
```
download opencv source code
open Powershell
cd opencv
mkdir build
cmake ..
cmake --build . --target opencv_perf_core opencv_perf_imgproc
cd bin/Release
./opencv_perf_core.exe or ./opencv_perf_imgproc.exe
```
