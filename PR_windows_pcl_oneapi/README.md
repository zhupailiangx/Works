# 修改记录
## Native PCL
### 1. 
用master中的 
common/include/pcl/for_each_type.h,common/include/pcl/impl/instantiate.hpp,common/src/fft/kiss_fft.c,kdtree/include/pcl/kdtree/kdtree_flann.h替换PR_windows中的
### 2.
common/include/pcl/impl/instantiate.hpp 98行#ifdef _MSC_VER 改为 #if (defined _WIN32 && defined _MSC_VER && !defined(__clang__))
### 3.
#if (defined _WIN32 && defined _MSC_VER) 修改为 #if (defined _WIN32 && defined _MSC_VER && !defined(__clang__))
### 4.
Native pcl CMakeLists.txt 用master 替换，306行添加
```
if(WIN32)
include("${PCL_SOURCE_DIR}/cmake/pcl_win_dir.cmake")
endif()
```


### ONEAPI
### 1.
oneapi/CMakeLists.txt 中set(CMAKE_CXX_FLAGS_RELEASE "-O3 /EHa /QxCORE-AVX2 /fp:fast") 修改为set(CMAKE_CXX_FLAGS_RELEASE "-O3 /EHa /QxCORE-AVX2")
### 2.
oneapi/common/CMakeLists.txt
```
IF(WIN32)
set_target_properties(${LIB_NAME} PROPERTIES VS_PLATFORM_TOOLSET ${INTEL_DPCPP_COMPILER} )
target_link_libraries("${LIB_NAME}" pcl_common pcl_oneapi_containers)
endif()
```
修改为
```
IF(WIN32)
target_link_libraries("${LIB_NAME}" pcl_common pcl_oneapi_containers)
endif()
```
### 3. 
oneapi/cmake/pcl_targets.cmake, 254 行添加
```
if (WIN32)
set_target_properties(${_name} PROPERTIES VS_PLATFORM_TOOLSET ${INTEL_DPCPP_COMPILER})
endif()
```
### 4.
oneapi/containers/CMakeLists.txt,oneapi/features/CMakeLists.txt,oneapi/filters/CMakeLists.txt,oneapi/kdtree/CMakeLists.txt,oneapi/octree/CMakeLists.txt,oneapi/registration/CMakeLists.txt,oneapi/registration_omp/CMakeLists.txt,oneapi/sample_consensus/CMakeLists.txt,oneapi/search/CMakeLists.txt,oneapi/segmentation/CMakeLists.txt,oneapi/surface/CMakeLists.txt,oneapi/surface_omp/CMakeLists.txt,
删除
```
if(WIN32)
set_target_properties(${LIB_NAME} PROPERTIES VS_PLATFORM_TOOLSET ${INTEL_DPCPP_COMPILER} )
endif()
```
### 5.
oneapi/utils/include/pcl/oneapi/utils/device/sort/util_type.hpp
```
#ifdef _WIN32
    __CUB_ALIGN_BYTES(sycl::long2, 8)
    __CUB_ALIGN_BYTES(sycl::ulong2, 8)
#else
    __CUB_ALIGN_BYTES(sycl::long2, 16)
    __CUB_ALIGN_BYTES(sycl::ulong2, 16)
#endif
```
修改为
```
__CUB_ALIGN_BYTES(sycl::long2, 8)
__CUB_ALIGN_BYTES(sycl::ulong2, 8)//需要实验和16的结果对比
```

## Test oneapi
### 1. 
CMakeLists.txt
 set(CMAKE_CXX_FLAGS_RELEASE "-O3 /EHa /QxCORE-AVX2 /fp:fast") 修改为
 set(CMAKE_CXX_FLAGS_RELEASE "-O3 /EHa /QxCORE-AVX2")
 
 ### 2.
 test\oneapi\cmake\pcl_targets.cmake, line 399.
添加
```
if(WIN32)
set_target_properties(${_exename} PROPERTIES VS_PLATFORM_TOOLSET "Intel(R) oneAPI DPC++ Compiler 2023" )
endif()
```
### 3.
test\oneapi\features\CMakeLists.txt
删除
```
if(WIN32)
set_target_properties(test_oneAPI_features_normals_function PROPERTIES VS_DEBUGGER_ENVIRONMENT  "SYCL_DEVICE_FILTER=ext_oneapi_level_zero:gpu
PATH=%PATH%;${SYCL_PATH};${PCL_ONEAPI_ROOT}/bin;${FLANN_ROOT}/bin;${PCL_BIN};${VTK_ROOT}/bin;${OPENNI2_BIN};${Qhull_ROOT}/bin")
endif()
```

### 4.
test/oneapi/filters/CMakeLists.txt
```
PCL_ADD_TEST(oneapi_passthrough test_oneapi_passthrough
             FILES test_oneapi_passthrough.cpp
             LINK_WITH pcl_gtest pcl_oneapi_filters pcl_oneapi_containers pcl_filters pcl_io
             ARGUMENTS "${PCL-ONEAPI-TEST_SOURCE_DIR}/using_kinfu_large_scale_output.pcd")
```
修改成
```
PCL_ADD_TEST(oneapi_passthrough test_oneapi_passthrough
             FILES test_oneapi_passthrough.cpp
             LINK_WITH pcl_gtest pcl_oneapi_filters pcl_oneapi_containers pcl_filters pcl_io)
```


```
PCL_ADD_TEST(oneapi_voxel_grid test_oneapi_voxel_grid
            FILES test_oneapi_voxel_grid.cpp
            LINK_WITH pcl_gtest pcl_oneapi_filters pcl_oneapi_containers pcl_filters pcl_io
            ARGUMENTS "${PCL-ONEAPI-TEST_SOURCE_DIR}/table_scene_lms400.pcd" )
            ```
```
PCL_ADD_TEST(oneapi_voxel_grid test_oneapi_voxel_grid
            FILES test_oneapi_voxel_grid.cpp
            LINK_WITH pcl_gtest pcl_oneapi_filters pcl_oneapi_containers pcl_filters pcl_io
            )
      ```
