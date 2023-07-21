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
