# 修改记录
### 1. common/include/pcl/impl/instantiate.hpp 98行#ifdef _MSC_VER 改为 #if (defined _WIN32 && defined _MSC_VER && !defined(__clang__))
### 2. #if (defined _WIN32 && defined _MSC_VER) 修改为 #if (defined _WIN32 && defined _MSC_VER && !defined(__clang__))
### 3. Native pcl Cmakelists.txt 用master 替换
