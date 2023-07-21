# Build and run OpenCV Perf 

## Linux
```
download opencv source code
cd <source code path>
mkdir build
cmake ..
make -j8 opencv_perf_core opencv_perf_imgproc
cd bin
./opencv_perf_core or ./opencv_perf_imgproc
```
{   perf_max_outliers           |8        |percent of allowed outliers}"
        "{   perf_min_samples            |10       |minimal required numer of samples}"
        "{   perf_force_samples          |100      |force set maximum number of samples for all tests}"
        "{   perf_seed                   |809564   |seed for random numbers generator}"
```
./opencv_perf_core -perf_min_samples=100 -perf_force_samples=100 (or any other number)
```
## Windows 
```
download opencv exe
open Powershell
cd opencv/sources
mkdir build
cmake ..
cmake --build . --target opencv_perf_core opencv_perf_imgproc
cd bin
./opencv_perf_core.exe or ./opencv_perf_imgproc.exe
```
