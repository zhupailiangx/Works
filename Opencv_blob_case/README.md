# Add Blob test case in features2d

## Add test case
```
Download https://github.com/opencv/opencv/archive/refs/tags/4.8.0.zip
cd opencv-4.8.0/modules/features2d/perf
```
文件 perf_features2d.cpp 中71行增加下面case

```
typedef tuple<MatType, int,int> Perf_Blob_t;
typedef perf::TestBaseWithParam<Perf_Blob_t> Perf_Blob;

PERF_TEST_P(Perf_Blob, Blob_detect,testing::Combine(
        testing::Values(CV_8UC1),
        testing::Values(2000), testing::Values(1000)))
{
    int matType = get<0>(GetParam());
    int size_height = get<1>(GetParam());
    int size_width = get<2>(GetParam());
    //std::cout << "size:" << size << std::endl;
    cv::Mat image = cv::Mat(cv::Size(size_height, size_width), matType, cv::Scalar(255, 255, 255));
    cv::circle(image, Point(50, 50), 20, cv::Scalar(0), -1);
    SimpleBlobDetector::Params params;
    params.minThreshold = 250;
    params.maxThreshold = 260;
    params.minRepeatability = 1;  
    std::vector<KeyPoint> keypoints;

    declare.in(image);
    Ptr<SimpleBlobDetector> detector = SimpleBlobDetector::create(params);

    TEST_CYCLE() detector->detect(image, keypoints);
   
    ASSERT_NE((int)keypoints.size(), 0);
    
    SANITY_CHECK_NOTHING();
}
```

## Linux Test

```
cd opencv-4.8.0
mkdir build
cd build
cmake -DWITH_TBB=OFF -DWITH_OPENMP=OFF -DWITH_PTHREADS_PF=OFF ..
make opencv_perf_features2d -j8
cd bin
export OPENCV_OPENCL_DEVICE=disabled
./opencv_perf_features2d --gtest_filter=*Blob* --perf_force_samples=1000 --perf_min_samples=1000
```

## 12700 test results

<table border=0 cellpadding=0 cellspacing=0 width=989 style='border-collapse:
 collapse;table-layout:fixed;width:743pt'>
 <col width=277 style='mso-width-source:userset;mso-width-alt:10130;width:208pt'>
 <col width=189 style='mso-width-source:userset;mso-width-alt:6912;width:142pt'>
 <col width=124 style='mso-width-source:userset;mso-width-alt:4534;width:93pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=126 style='mso-width-source:userset;mso-width-alt:4608;width:95pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 width=277 style='height:15.0pt;width:208pt'>Name of
  Test</td>
  <td class=xl65 width=189 style='border-left:none;width:142pt'>Number
  ofcollected samples</td>
  <td class=xl65 width=124 style='border-left:none;width:93pt'>Number
  ofoutliers</td>
  <td class=xl65 width=53 style='border-left:none;width:40pt'>Min</td>
  <td class=xl65 width=55 style='border-left:none;width:41pt'>Median</td>
  <td class=xl65 width=112 style='border-left:none;width:84pt'>Geometric mean</td>
  <td class=xl65 width=53 style='border-left:none;width:40pt'>Mean</td>
  <td class=xl65 width=126 style='border-left:none;width:95pt'>Standard
  deviation</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 style='height:15.0pt;border-top:none'>Blob_detect::Perf_Blob::(8UC1,
  2000, 1000)</td>
  <td class=xl66 align=right style='border-top:none;border-left:none'>1000</td>
  <td class=xl66 align=right style='border-top:none;border-left:none'>80</td>
  <td class=xl66 style='border-top:none;border-left:none'>0.80 ms</td>
  <td class=xl66 style='border-top:none;border-left:none'>0.82 ms</td>
  <td class=xl66 style='border-top:none;border-left:none'>0.82 ms</td>
  <td class=xl66 style='border-top:none;border-left:none'>0.82 ms</td>
  <td class=xl66 style='border-top:none;border-left:none'>0.01 ms</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=277 style='width:208pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=126 style='width:95pt'></td>
 </tr>
 <![endif]>
</table>

</body>

