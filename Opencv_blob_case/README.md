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

