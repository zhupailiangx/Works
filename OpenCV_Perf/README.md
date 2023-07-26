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



<table border=0 cellpadding=0 cellspacing=0 width=1876 style='border-collapse:
 collapse;table-layout:fixed;width:1408pt'>
 <col width=812 style='mso-width-source:userset;mso-width-alt:29696;width:609pt'>
 <col width=236 style='mso-width-source:userset;mso-width-alt:8630;width:177pt'>
 <col width=232 style='mso-width-source:userset;mso-width-alt:8484;width:174pt'>
 <col width=258 style='mso-width-source:userset;mso-width-alt:9435;width:194pt'>
 <col width=232 style='mso-width-source:userset;mso-width-alt:8484;width:174pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <tr height=20 style='height:15.0pt'>
  <td colspan=6 height=20 class=xl67 width=1876 align="center" style='height:15.0pt;
  width:1408pt'>&#27979;&#35797;&#32467;&#26524;&#25193;&#23637;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>Case</td>
  <td class=xl65 style='border-top:none;border-left:none'>Size</td>
  <td class=xl65 style='border-top:none;border-left:none'>Type of data</td>
  <td class=xl65 style='border-top:none;border-left:none'>Type1</td>
  <td class=xl65 style='border-top:none;border-left:none'>Type2</td>
  <td class=xl65 style='border-top:none;border-left:none'>Number of tests</td>
 </tr>
 <tr height=40 style='height:30.0pt'>
  <td height=40 class=xl65 style='height:30.0pt;border-top:none'>Size_MatType_abs.abs</td>
  <td class=xl66 width=236 style='border-top:none;border-left:none;width:177pt'>(640,
  480),(1280, 720)<br>
    (1280, 720),(127, 61)</td>
  <td class=xl66 width=232 style='border-top:none;border-left:none;width:174pt'><span
  style='mso-spacerun:yes'>  </span>8SC1, 8SC4, <br>
    32SC1, 32FC1</td>
  <td class=xl66 width=258 style='border-top:none;border-left:none;width:194pt'>&nbsp;</td>
  <td class=xl66 width=232 style='border-top:none;border-left:none;width:174pt'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>4*4=16</td>
 </tr>
 <tr height=40 style='height:30.0pt'>
  <td height=40 class=xl65 style='height:30.0pt;border-top:none'>Size_MatType_addWeighted.addWeighted</td>
  <td class=xl66 width=236 style='border-top:none;border-left:none;width:177pt'>(640,
  480),(1280, 720),<br>
    (1920, 1080)</td>
  <td class=xl66 width=232 style='border-top:none;border-left:none;width:174pt'>8UC1,
  8UC4,8SC1,<br>
    <span style='mso-spacerun:yes'> </span>16UC1, 16SC1, 32SC1</td>
  <td class=xl66 width=258 style='border-top:none;border-left:none;width:194pt'>&nbsp;</td>
  <td class=xl66 width=232 style='border-top:none;border-left:none;width:174pt'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>3*6=18</td>
 </tr>
 <tr height=60 style='height:45.0pt'>
  <td height=60 class=xl65 style='height:45.0pt;border-top:none'>OCL_CompareFixture_Compare.Compare</td>
  <td class=xl66 width=236 style='border-top:none;border-left:none;width:177pt'>(640,480),(1280,720)<br>
    &#65288;1920,1080),(3840,2160&#65289;<br>
    </td>
  <td class=xl66 width=232 style='border-top:none;border-left:none;width:174pt'><span
  style='mso-spacerun:yes'> </span>8UC1&#65292;32FC1&#65292;8UC3&#65292;32FC3,<br>
    <span style='mso-spacerun:yes'> </span>8UC4,32FC4,</td>
  <td class=xl66 width=258 style='border-top:none;border-left:none;width:194pt'>CMP_LT&#65292;CMP_LE&#65292;CMP_EQ&#65292;<br>
    CMP_NE&#65292;CMP_GE&#65292;CMP_GT</td>
  <td class=xl65 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>4*6*6=144</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>Size_MatType_dx_dy_Border3x3_scharrViaSobelFilter.scharrViaSobelFilter</td>
  <td class=xl66 width=236 style='border-top:none;border-left:none;width:177pt'>(127,61),(320,240),(640,480)</td>
  <td class=xl66 width=232 style='border-top:none;border-left:none;width:174pt'>16SC1,32FC1</td>
  <td class=xl65 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>(0, 1),(1, 0)</td>
  <td class=xl65 style='border-top:none;border-left:none'>BORDER_REPLICATE,BORDER_CONSTANT</td>
  <td class=xl65 style='border-top:none;border-left:none'>3*2*2*2=24</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=812 style='width:609pt'></td>
  <td width=236 style='width:177pt'></td>
  <td width=232 style='width:174pt'></td>
  <td width=258 style='width:194pt'></td>
  <td width=232 style='width:174pt'></td>
  <td width=106 style='width:80pt'></td>
 </tr>
 <![endif]>
</table>


### gtest filter results
Example 
固定samples，case，size和type
```
./opencv_perf_core -perf_min_samples=100 -perf_force_samples=100 --gtest_filter=Size_MatType_NormType_norm* --gtest_param_filter=*640x480*?*8UC1*
```
![image](https://github.com/zhupailiangx/Works/assets/120553507/db0c2f38-c59c-49c8-9256-2f5b38ef7d58)

```
./opencv_perf_core --gtest_param_filter=*640x480*?*8UC1*
./opencv_perf_imgproc   --gtest_param_filter=*640x480*?*8UC1*
```
<body link="#0563C1" vlink="#954F72">

<table border=0 cellpadding=0 cellspacing=0 width=474 style='border-collapse:
 collapse;table-layout:fixed;width:356pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=64 style='width:48pt'>
 <col width=96 span=2 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 width=108 style='height:15.0pt;width:81pt'>&nbsp;</td>
  <td class=xl65 width=64 style='border-left:none;width:48pt'>Core</td>
  <td class=xl65 width=96 style='border-left:none;width:72pt'>Filtered Core</td>
  <td class=xl65 width=96 style='border-left:none;width:72pt'>ImgProc</td>
  <td class=xl65 width=110 style='border-left:none;width:83pt'>Filtered imgProc</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>Number of
  case<span style='mso-spacerun:yes'> </span></td>
  <td class=xl65 style='border-top:none;border-left:none'>125</td>
  <td class=xl65 style='border-top:none;border-left:none'>76</td>
  <td class=xl65 style='border-top:none;border-left:none'>146</td>
  <td class=xl65 style='border-top:none;border-left:none'>67</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt;border-top:none'>Number of
  tests</td>
  <td class=xl65 style='border-top:none;border-left:none'>4131</td>
  <td class=xl65 style='border-top:none;border-left:none'>209</td>
  <td class=xl65 style='border-top:none;border-left:none'>5384</td>
  <td class=xl65 style='border-top:none;border-left:none'>149</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=108 style='width:81pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

## 结论
过滤测试结果，可以固定图像尺寸和数据类型
