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


## Test oneapi
### 1. 
CMakeLists.txt
 set(CMAKE_CXX_FLAGS_RELEASE "-O3 /EHa /QxCORE-AVX2 /fp:fast") 修改为
 set(CMAKE_CXX_FLAGS_RELEASE "-O3 /EHa /QxCORE-AVX2")
 
 ### 2. (还原修改)
 test\oneapi\cmake\pcl_targets.cmake, line 399.
添加
```
if(WIN32)
//set_target_properties(${_exename} PROPERTIES VS_PLATFORM_TOOLSET "Intel(R) oneAPI DPC++ Compiler 2023" )
set_target_properties(${_exename} PROPERTIES VS_PLATFORM_TOOLSET ${INTEL_DPCPP_COMPILER} )
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
修改成
```
PCL_ADD_TEST(oneapi_voxel_grid test_oneapi_voxel_grid
            FILES test_oneapi_voxel_grid.cpp
            LINK_WITH pcl_gtest pcl_oneapi_filters pcl_oneapi_containers pcl_filters pcl_io
            )
 ```
```
PCL_ADD_TEST(oneapi_statistical_outlier_removal test_oneapi_statistical_outlier_removal
            FILES test_oneapi_statistical_outlier_removal.cpp
            LINK_WITH pcl_gtest pcl_oneapi_filters pcl_oneapi_containers pcl_filters pcl_kdtree pcl_search pcl_io
            ARGUMENTS "${PCL-ONEAPI-TEST_SOURCE_DIR}/cloud.pcd" )
```
修改成
```
PCL_ADD_TEST(oneapi_statistical_outlier_removal test_oneapi_statistical_outlier_removal
            FILES test_oneapi_statistical_outlier_removal.cpp
            LINK_WITH pcl_gtest pcl_oneapi_filters pcl_oneapi_containers pcl_filters pcl_kdtree pcl_search pcl_io
            )
```

删除
```
if(WIN32)
set_target_properties(  test_oneapi_passthrough 
                        test_oneapi_passthrough_perf
                        test_oneapi_statistical_outlier_removal
                        test_oneapi_statistical_outlier_removal_perf
                        test_oneapi_voxel_grid
                        test_oneapi_voxel_grid_perf
                        PROPERTIES VS_DEBUGGER_ENVIRONMENT  "SYCL_DEVICE_FILTER=ext_oneapi_level_zero:gpu
PATH=%PATH%;${SYCL_PATH};${PCL_ONEAPI_ROOT}/bin;${FLANN_ROOT}/bin;${PCL_BIN};${VTK_ROOT}/bin;${OPENNI2_BIN};${Qhull_ROOT}/bin")
set_target_properties( test_oneapi_voxel_grid_perf PROPERTIES VS_DEBUGGER_COMMAND_ARGUMENTS "${PCL-ONEAPI-TEST_SOURCE_DIR}/table_scene_lms400.pcd" )
set_target_properties( test_oneapi_statistical_outlier_removal_perf PROPERTIES VS_DEBUGGER_COMMAND_ARGUMENTS "${PCL-ONEAPI-TEST_SOURCE_DIR}/cloud.pcd" )
set_target_properties( test_oneapi_passthrough_perf PROPERTIES VS_DEBUGGER_COMMAND_ARGUMENTS "${PCL-ONEAPI-TEST_SOURCE_DIR}/using_kinfu_large_scale_output.pcd" )

endif()
```

### 5.
test/oneapi/filters_omp/CMakeLists.txt
删除
```
if(WIN32)
set_target_properties(test_filters_omp PROPERTIES VS_PLATFORM_TOOLSET ${INTEL_CPP_COMPILER})
set_target_properties(test_filters_omp PROPERTIES VS_DEBUGGER_ENVIRONMENT  "PATH=%PATH%;${SYCL_PATH};${PCL_ONEAPI_ROOT}/bin;${FLANN_ROOT}/bin;${PCL_BIN};${VTK_ROOT}/bin;${OPENNI2_BIN}")
endif()
```

### 6.
test/oneapi/kdtree/CMakeLists.txt
删除
```
if(WIN32)
set_target_properties(  test_oneapi_kdtree 
                        test_oneapi_kdtree_perf
                        PROPERTIES VS_DEBUGGER_ENVIRONMENT  "SYCL_DEVICE_FILTER=ext_oneapi_level_zero:gpu
PATH=%PATH%;${SYCL_PATH};${PCL_ONEAPI_ROOT}/bin;${FLANN_ROOT}/bin;${PCL_BIN};${VTK_ROOT}/bin;${OPENNI2_BIN};${Qhull_ROOT}/bin")


set_target_properties(  test_oneapi_kdtree_perf 
                        PROPERTIES VS_DEBUGGER_COMMAND_ARGUMENTS "${PCL-ONEAPI-TEST_SOURCE_DIR}/test_P.pcd ${PCL-ONEAPI-TEST_SOURCE_DIR}/test_Q.pcd" )


endif()

```

### 7.
test/oneapi/octree/CMakeLists.txt
```
PCL_ADD_TEST(oneAPI_octree_approx_nearest_function test_oneAPI_approx_nearest_function 
                    FILES test_oneapi_approx_nearest_function.cpp 
                    LINK_WITH pcl_gtest pcl_common pcl_octree pcl_oneapi_octree pcl_io
                    ARGUMENTS "${PCL-ONEAPI-TEST_SOURCE_DIR}/test_P.pcd ${PCL-ONEAPI-TEST_SOURCE_DIR}/test_Q.pcd")
  
```

```
PCL_ADD_TEST(oneAPI_octree_approx_nearest_function test_oneAPI_approx_nearest_function 
                    FILES test_oneapi_approx_nearest_function.cpp 
                    LINK_WITH pcl_gtest pcl_common pcl_octree pcl_oneapi_octree pcl_io
                    )
```

删除
```
if(WIN32)
set_target_properties(  test_oneAPI_approx_nearest_function
                        test_oneAPI_approx_nearest_performance
                        test_oneAPI_knn_search_function
                        test_oneAPI_knn_search_performance
                        test_oneAPI_radius_search_function
                        test_oneAPI_radius_search_performance
                        PROPERTIES VS_DEBUGGER_ENVIRONMENT  "SYCL_DEVICE_FILTER=ext_oneapi_level_zero:gpu
PATH=%PATH%;${SYCL_PATH};${PCL_ONEAPI_ROOT}/bin;${FLANN_ROOT}/bin;${PCL_BIN};${VTK_ROOT}/bin;${OPENNI2_BIN};${Qhull_ROOT}/bin;${YAML_CPP_BIN}")

set_target_properties(  test_oneAPI_approx_nearest_performance 
                        test_oneAPI_knn_search_performance
                        PROPERTIES VS_DEBUGGER_COMMAND_ARGUMENTS "${PCL-ONEAPI-TEST_SOURCE_DIR}/test_P.pcd ${PCL-ONEAPI-TEST_SOURCE_DIR}/test_Q.pcd" )

endif()
```

### 8.
test/oneapi/registration/CMakeLists.txt
删除
string(APPEND CMAKE_CXX_FLAGS " -msse4.1")



## 结果
<table border=0 cellpadding=0 cellspacing=0 width=1292 style='border-collapse:
 collapse;table-layout:fixed;width:969pt'>
 <col width=302 style='mso-width-source:userset;mso-width-alt:11044;width:227pt'>
 <col width=512 style='mso-width-source:userset;mso-width-alt:18724;width:384pt'>
 <col width=135 style='mso-width-source:userset;mso-width-alt:4937;width:101pt'>
 <col width=279 style='mso-width-source:userset;mso-width-alt:10203;width:209pt'>
 <col width=64 style='width:48pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 width=302 style='height:15.0pt;width:227pt'>Platfrom
  : ADL<span style='mso-spacerun:yes'>  </span>OS: Linux/Windows</td>
  <td class=xl67 width=512 style='border-left:none;width:384pt'>&nbsp;</td>
  <td class=xl67 width=135 style='border-left:none;width:101pt'>&nbsp;</td>
  <td class=xl67 width=279 style='border-left:none;width:209pt'>&nbsp;</td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl68 style='border-left:none'>Function Status</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt;border-top:none'>Test Operators</td>
  <td class=xl69 style='border-top:none;border-left:none'>Case</td>
  <td class=xl70 style='border-top:none;border-left:none'>Linux</td>
  <td class=xl71 style='border-top:none;border-left:none'>Windows</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_oneapi_correspondence_estimation<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none'>CorrespondenceEstimation.CorrespondenceEstimationSetSearchMethod</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>CorrespondenceEstimation.CorrespondenceEstimation</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>CorrespondenceEstimation.ReciprocalCorrespondenceEstimationUnsupported</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>test_oneapi_registration</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.ICP_translated</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.IterativeClosestPointDPCPP</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.IterativeClosestPointReciprocalDPCPPUnsupported</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_oneapi_kdtree_search</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL.KdTree_differentPointT</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL.KdTree_multipointKnnSearch</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL.KdTree_radiusSearch</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>test_oneapi_kdtree</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.KdTreeFLANN_radiusSearch</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.KdTreeFLANN_fixedRadiusSearch</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.KdTreeFLANN_knnSearch</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_oneAPI_radius_search_function</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_OneAPI_Octree.OneAPI_Octree_Radius_Search_Function</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>test_oneAPI_knn_search_function</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL_OctreeOneAPI.OneAPI_Octree_KNNSearch</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_oneAPI_approx_nearest_function</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_OneAPI_Octree.OneAPI_Octree_approxNearestSearch</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(0.03!=0.03)</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_OneAPI_Octree.OneAPI_Octree_approxNearestSearch_pcd</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>test_oneapi_sample_consensus_plane_models</td>
  <td class=xl74 style='border-top:none;border-left:none'>oneAPI_SampleConsensusModelPlane.RANSAC_minimum_iteration</td>
  <td class=xl75 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>oneAPI_SampleConsensusModelPlane.RANSAC_optimum_iteration</td>
  <td class=xl75 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>oneAPI_SampleConsensusModelPlane.RANSAC_maximum_iteration</td>
  <td class=xl75 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_oneapi_segmentation</td>
  <td class=xl72 style='border-top:none;border-left:none'>oneAPI_PCLCPU_SACSegmentation.CompareResults_minimum_iteration</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>oneAPI_PCLCPU_SACSegmentation.CompareResults_optimum_iteration</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>oneAPI_PCLCPU_SACSegmentation.CompareResults_maximum_itertaion</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>test_oneapi_convex_hull_function</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>Del</td>
  <td class=xl75 style='border-top:none;border-left:none'>Del</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_mls</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_ONEAPI_MLS.test_radius_configuration</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_ONEAPI_MLS.test_projection_normal_simple</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_ONEAPI_MLS.test_projection_normal_orthogonal</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_ONEAPI_MLS.test_projection_sample_local_plane_simple</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_ONEAPI_MLS.test_projection_random_uniform_density_simple</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_ONEAPI_MLS.test_projection_random_uniform_density_orthogonal</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_ONEAPI_MLS.test_projection_voxel_grid_dilation</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL_ONEAPI_MLS.test_projection_distinct_cloud</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>test_oneapi_voxel_grid</td>
  <td class=xl74 style='border-top:none;border-left:none'>oneAPI_filters.VoxelGrid</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK(Core dumped)</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_oneapi_passthrough<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none'>oneAPI_filters.PassThrough</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>test_oneapi_statistical_outlier_removal<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.Oneap_filters.Statistical_Outlier_Removeal</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK(Core dumped)</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_filters_omp</td>
  <td class=xl72 style='border-top:none;border-left:none'>StatisticalOutlierRemoval.Filters</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>test_oneAPI_features_normals_function<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL_FeaturesOneAPI.normals_knn
  (3502 ms)</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL_FeaturesOneAPI.normals_radius
  (49635 ms)</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL_FeaturesOneAPI.issue_2371</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_oneapi_sac_ia_omp<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL.SampleConsensusInitialAlignment</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL.SampleConsensusPrerejective</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>test_oneapi_registration_omp</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.findFeatureCorrespondences</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.ICP_translated</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.IterativeClosestPoint</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>PCL.PPFRegistration</td>
  <td class=xl75 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>test_moving_least_squares_omp</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL.MovingLeastSquares</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>PCL.MovingLeastSquaresOMP</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>ok</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=302 style='width:227pt'></td>
  <td width=512 style='width:384pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=279 style='width:209pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>


<table border=0 cellpadding=0 cellspacing=0 width=676 style='border-collapse:
 collapse;table-layout:fixed;width:508pt'>
 <col width=461 style='mso-width-source:userset;mso-width-alt:16859;width:346pt'>
 <col width=150 style='mso-width-source:userset;mso-width-alt:5485;width:113pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 width=461 style='height:15.0pt;width:346pt'>Platfrom
  : ADL<span style='mso-spacerun:yes'>   </span>OS: Linux/Windows</td>
  <td class=xl67 width=150 style='border-left:none;width:113pt'>&nbsp;</td>
  <td class=xl67 width=65 style='border-left:none;width:49pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl77 style='border-left:none'>Perf status</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt;border-top:none'>Case</td>
  <td class=xl78 style='border-top:none;border-left:none'>Linux</td>
  <td class=xl78 style='border-top:none;border-left:none'>Windows</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL.IterativeClosestPointDPCPPPerf</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL.KdTree_multipointKnnSearchPerf</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL.KdTree_radiusSearchPerf</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL.KdTreeFLANN_radiusSearch</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL.KdTreeFLANN_fixedRadiusSearch_native_buffer</td>
  <td class=xl75 style='border-top:none;border-left:none'>Failed</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL.KdTreeFLANN_fixedRadiusSearch_std_vector</td>
  <td class=xl75 style='border-top:none;border-left:none'>Failed</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL.KdTreeFLANN_fixedRadiusSearchUnSort</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL.KdTreeFLANN_knnSearch</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL_OneAPI_Octree.OneAPI_Octree_Radius_Search_Performance</td>
  <td class=xl81 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL_OneAPI_Octree.OneAPI_Octree_KNNSearch_Performance</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL_OneAPI_Octree.OneAPI_Octree_approxNearestSearch_Performance</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>oneAPI_SampleConsensusModelPlane_RANSAC.testGPUPerf</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(Core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>oneAPI_SACSegmentation.testGPUPerf</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL_OneAPI_ConvexHull.OneAPI_pseudoConvexHull_performance</td>
  <td class=xl73 style='border-top:none;border-left:none'>DEL</td>
  <td class=xl73 style='border-top:none;border-left:none'>DEL</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL_ONEAPI_MLS.test_projection_normal_simple</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL_ONEAPI_MLS.test_projection_normal_orthogonal</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK(core dumped)</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>oneAPI_filters_perf.VoxelGrid</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>oneAPI_filters_perf.PassThrough</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(core
  dumped)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL.Oneap_filters.Statistical_Outlier_Removeal_performance</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL_FeaturesOneAPIPerf.normals_knn</td>
  <td class=xl75 style='border-top:none;border-left:none'>Failed</td>
  <td class=xl75 style='border-top:none;border-left:none'>Failed</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL_FeaturesOneAPIPerf.normals_radius_1</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt;border-top:none'>PCL_FeaturesOneAPIPerf.normals_radius_2</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
  <td class=xl75 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL.GreedyProjectionTriangulation_performance</td>
  <td class=xl73 style='border-top:none;border-left:none'>Failed(core dumped)</td>
  <td class=xl73 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl79 style='height:15.0pt;border-top:none'>PCL.GreedyProjectionTriangulation_performance_meshcleanup</td>
  <td class=xl82 style='border-top:none;border-left:none'>Failed(core dumped)</td>
  <td class=xl82 style='border-top:none;border-left:none'>OK</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=461 style='width:346pt'></td>
  <td width=150 style='width:113pt'></td>
  <td width=65 style='width:49pt'></td>
 </tr>
 <![endif]>
</table>

</body>



## Linux问题发现及修改
修改之后的PCL-ONEAPI 在Linux系统上测试案例有很多的失败（可以在上面表格中发现），经过实验发现C++14 和C++ 17两个版本对Native PCL的编译方式不同。
给定的build_pcl_native.sh脚本中
```
#!/bin/bash
if [ ! -d ../build ]; then
   mkdir ../build
fi
cd ../build
#Need to specify the CMAKE_CXX_FLAGS. Otherwise, -march=native will be used and 
#that could cause segmentation fault if PCL ondAPI is built with that flag.
#Since we want the pre-built library to be compatible to most HW, it makse sense
#to build without -march=native. PCL library downloaded from Ubuntu APT repo 
#is not built with -march=native either.
cmake -DCMAKE_CXX_FLAGS="-Wabi=11 -Wall -Wextra -Wno-unknown-pragmas -fno-strict-aliasing -Wno-format-extra-args -Wno-sign-compare -Wno-invalid-offsetof -Wno-conversion" ../
make -j$(nproc)
sudo make install
```
修改成17之后的编译方式应该修改为
```
#!/bin/bash
if [ ! -d ../build ]; then
   mkdir ../build
fi
cd ../build

cmake ..
make -j$(nproc)
sudo make install
```


