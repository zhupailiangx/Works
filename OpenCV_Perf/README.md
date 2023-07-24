# Build and run OpenCV Perf 

## Linux
```
download opencv source code
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
download opencv source code
open Powershell
cd opencv
mkdir build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PERF_TESTS=ON ..
cmake --build . --target opencv_perf_core opencv_perf_imgproc
cd bin/Release
./opencv_perf_core.exe
./opencv_perf_imgproc.exe
```
## Result
Time compensation is 0
TEST: Skip tests with tags: 'mem_6gb', 'verylong'
CTEST_FULL_OUTPUT
OpenCV version: 4.5.5
OpenCV VCS version: unknown
Build type: Release
Compiler: /usr/bin/c++  (ver 11.3.0)
Parallel framework: pthreads (nthreads=4)
CPU features: SSE SSE2 SSE3 *SSE4.1 *SSE4.2 *FP16 *AVX *AVX2 *AVX512-SKX
OpenCL Platforms: 
    Intel(R) OpenCL HD Graphics
        iGPU: Intel(R) Iris(R) Xe Graphics (OpenCL 3.0 NEO )
Current OpenCL device: 
    Type = iGPU
    Name = Intel(R) Iris(R) Xe Graphics
    Version = OpenCL 3.0 NEO 
    Driver version = 23.05.25593.11
    Address bits = 64
    Compute units = 80
    Max work group size = 512
    Local memory size = 64 KB
    Max memory allocation size = 2 GB 923 MB 978 KB
    Double support = No
    Half support = Yes
    Host unified memory = Yes
    Device extensions:
        cl_khr_byte_addressable_store
        cl_khr_device_uuid
        cl_khr_fp16
        cl_khr_global_int32_base_atomics
        cl_khr_global_int32_extended_atomics
        cl_khr_icd
        cl_khr_local_int32_base_atomics
        cl_khr_local_int32_extended_atomics
        cl_intel_command_queue_families
        cl_intel_subgroups
        cl_intel_required_subgroup_size
        cl_intel_subgroups_short
        cl_khr_spir
        cl_intel_accelerator
        cl_intel_driver_diagnostics
        cl_khr_priority_hints
        cl_khr_throttle_hints
        cl_khr_create_command_queue
        cl_intel_subgroups_char
        cl_intel_subgroups_long
        cl_khr_il_program
        cl_intel_mem_force_host_memory
        cl_khr_subgroup_extended_types
        cl_khr_subgroup_non_uniform_vote
        cl_khr_subgroup_ballot
        cl_khr_subgroup_non_uniform_arithmetic
        cl_khr_subgroup_shuffle
        cl_khr_subgroup_shuffle_relative
        cl_khr_subgroup_clustered_reduce
        cl_intel_device_attribute_query
        cl_khr_suggested_local_work_size
        cl_intel_split_work_group_barrier
        cl_intel_spirv_media_block_io
        cl_intel_spirv_subgroups
        cl_khr_spirv_no_integer_wrap_decoration
        cl_intel_unified_shared_memory
        cl_khr_mipmap_image
        cl_khr_mipmap_image_writes
        cl_intel_planar_yuv
        cl_intel_packed_yuv
        cl_khr_int64_base_atomics
        cl_khr_int64_extended_atomics
        cl_khr_image2d_from_buffer
        cl_khr_depth_images
        cl_khr_3d_image_writes
        cl_intel_media_block_io
        cl_intel_sharing_format_query
        cl_khr_pci_bus_info
        cl_intel_subgroup_local_block_io
    Has AMD Blas = No
    Has AMD Fft = No
    Preferred vector width char = 16
    Preferred vector width short = 8
    Preferred vector width int = 4
    Preferred vector width long = 1
    Preferred vector width float = 1
    Preferred vector width double = 0
    Preferred vector width half = 8
[==========] Running 4131 tests from 125 test cases.
[----------] Global test environment set-up.
[----------] 16 tests from OCL_LUTFixture_LUT
[ RUN      ] OCL_LUTFixture_LUT.LUT/0, where GetParam() = (640x480, 8UC1)
[ PERFSTAT ]    (samples=100   mean=0.21   median=0.20   min=0.19   stddev=0.04 (17.4%))
[       OK ] OCL_LUTFixture_LUT.LUT/0 (25 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/1, where GetParam() = (640x480, 32FC1)
[ PERFSTAT ]    (samples=100   mean=0.40   median=0.38   min=0.38   stddev=0.04 (9.2%))
[       OK ] OCL_LUTFixture_LUT.LUT/1 (50 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/2, where GetParam() = (640x480, 8UC4)
[ PERFSTAT ]    (samples=100   mean=0.48   median=0.48   min=0.47   stddev=0.02 (4.7%))
[       OK ] OCL_LUTFixture_LUT.LUT/2 (56 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/3, where GetParam() = (640x480, 32FC4)
[ PERFSTAT ]    (samples=88   mean=0.99   median=0.99   min=0.97   stddev=0.03 (2.8%))
[       OK ] OCL_LUTFixture_LUT.LUT/3 (101 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/4, where GetParam() = (1280x720, 8UC1)
[ PERFSTAT ]    (samples=100   mean=0.37   median=0.34   min=0.34   stddev=0.05 (12.8%))
[       OK ] OCL_LUTFixture_LUT.LUT/4 (47 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/5, where GetParam() = (1280x720, 32FC1)
[ PERFSTAT ]    (samples=63   mean=0.96   median=0.96   min=0.94   stddev=0.03 (2.9%))
[       OK ] OCL_LUTFixture_LUT.LUT/5 (70 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/6, where GetParam() = (1280x720, 8UC4)
[ PERFSTAT ]    (samples=88   mean=1.11   median=1.10   min=1.10   stddev=0.03 (2.7%))
[       OK ] OCL_LUTFixture_LUT.LUT/6 (113 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/7, where GetParam() = (1280x720, 32FC4)
[ PERFSTAT ]    (samples=63   mean=2.55   median=2.54   min=2.51   stddev=0.06 (2.2%))
[       OK ] OCL_LUTFixture_LUT.LUT/7 (188 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/8, where GetParam() = (1920x1080, 8UC1)
[ PERFSTAT ]    (samples=13   mean=0.67   median=0.67   min=0.67   stddev=0.00 (0.6%))
[       OK ] OCL_LUTFixture_LUT.LUT/8 (14 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/9, where GetParam() = (1920x1080, 32FC1)
[ PERFSTAT ]    (samples=63   mean=1.91   median=1.90   min=1.88   stddev=0.05 (2.9%))
[       OK ] OCL_LUTFixture_LUT.LUT/9 (138 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/10, where GetParam() = (1920x1080, 8UC4)
[ PERFSTAT ]    (samples=13   mean=2.21   median=2.18   min=2.17   stddev=0.06 (2.6%))
[       OK ] OCL_LUTFixture_LUT.LUT/10 (46 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/11, where GetParam() = (1920x1080, 32FC4)
[ PERFSTAT ]    (samples=10   mean=5.44   median=5.40   min=5.36   stddev=0.08 (1.6%))
[       OK ] OCL_LUTFixture_LUT.LUT/11 (93 ms)
[ RUN      ] OCL_LUTFixture_LUT.LUT/12, where GetParam() = (3840x2160, 8UC1)
[ PERFSTAT ]    (samples=38   mean=2.17   median=2.15   min=2.13   stddev=0.05 (2.5%))
[       OK ] OCL_LUTFixture_LUT.LUT/12 (104 ms)


```
samples - number of collected samples;
min - minimal observed time;
median - median over all collected time measurements;
mean - mean;
stddev - standard deviation.
```
