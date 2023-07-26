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
### Original core results
![image](https://github.com/zhupailiangx/Works/assets/120553507/73470fe8-5d84-4425-93ac-49a7bd9f531c)


```
samples - number of collected samples;
min - minimal observed time;
median - median over all collected time measurements;
mean - mean;
stddev - standard deviation.
```

S = 有符号整型 U = 无符号整型 F = 浮点型

CV_8U - 8位无符号整数

CV_8S - 8位有符号整数

CV_16U - 16位无符号整数

CV_16S - 16位有符号整数

CV_32S - 32位有符号整数

CV_32F - 32位浮点数

CV_64F - 64位浮点数



<table border=0 cellpadding=0 cellspacing=0 width=1288 style='border-collapse:
 collapse;table-layout:fixed;width:967pt'>
 <col width=812 style='mso-width-source:userset;mso-width-alt:29696;width:609pt'>
 <col width=138 style='mso-width-source:userset;mso-width-alt:5046;width:104pt'>
 <col width=232 style='mso-width-source:userset;mso-width-alt:8484;width:174pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <tr height=20 style='height:15.0pt'>
  <td colspan=4 height=20 class=xl67 align ="center" width=1288 style='height:15.0pt;
  width:967pt'>Core</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>case</td>
  <td class=xl65 style='border-top:none;border-left:none'>Size</td>
  <td class=xl65 style='border-top:none;border-left:none'>Type</td>
  <td class=xl65 style='border-top:none;border-left:none'>number of tests</td>
 </tr>
 <tr height=40 style='height:30.0pt'>
  <td height=40 class=xl65 style='height:30.0pt;border-top:none'>Size_MatType_abs</td>
  <td class=xl66 width=138 style='border-top:none;border-left:none;width:104pt'>(640,
  480),(1280, 720)<br>
    (1280, 720),(127, 61)</td>
  <td class=xl66 width=232 style='border-top:none;border-left:none;width:174pt'><span
  style='mso-spacerun:yes'>  </span>CV_8SC1, CV_8SC4, <br>
    CV_32SC1, CV_32FC1</td>
  <td class=xl65 style='border-top:none;border-left:none'>16</td>
 </tr>
 <tr height=60 style='height:45.0pt'>
  <td height=60 class=xl65 style='height:45.0pt;border-top:none'>Size_MatType_addWeighted</td>
  <td class=xl66 width=138 style='border-top:none;border-left:none;width:104pt'>(640,
  480),(1280, 720),<br>
    (1920, 1080)</td>
  <td class=xl66 width=232 style='border-top:none;border-left:none;width:174pt'>CV_8UC1,
  CV_8UC4, CV_8SC1,<br>
    <span style='mso-spacerun:yes'> </span>CV_16UC1, CV_16SC1, CV_32SC1</td>
  <td class=xl65 style='border-top:none;border-left:none'>18</td>
</table>

</body>


### gtest filter results
Example 
固定samples，case，size和type
```
./opencv_perf_core -perf_min_samples=100 -perf_force_samples=100 --gtest_filter=Size_MatType_NormType_norm* --gtest_param_filter=*640x480*?*8UC1*
```
![image](https://github.com/zhupailiangx/Works/assets/120553507/db0c2f38-c59c-49c8-9256-2f5b38ef7d58)

