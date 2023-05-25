# 修改记录
## Native PCL
### 0. 用master中的 
common/include/pcl/for_each_type.h,common/include/pcl/impl/instantiate.hpp,common/src/fft/kiss_fft.c,kdtree/include/pcl/kdtree/kdtree_flann.h替换PR_windows中的
### 1. common/include/pcl/impl/instantiate.hpp 98行#ifdef _MSC_VER 改为 #if (defined _WIN32 && defined _MSC_VER && !defined(__clang__))
### 2. #if (defined _WIN32 && defined _MSC_VER) 修改为 #if (defined _WIN32 && defined _MSC_VER && !defined(__clang__))
### 3. Native pcl CMakeLists.txt 用master 替换，306行添加
```
if(WIN32)
include("${PCL_SOURCE_DIR}/cmake/pcl_win_dir.cmake")
endif()
```
