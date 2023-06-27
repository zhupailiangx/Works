#
cmake_minimum_required(VERSION 2.8)

Project(Test1)
if(WIN32)
    set(CMAKE_GENERATOR_TOOLSET "Intel(R) oneAPI DPC++ Compiler 2023")
    #set(OpenCV_DIR "C:/Users/RS/Downloads/opencv_4.5.5/build")
    set(IPP_INCLUDE_DIR "C:/Program Files (x86)/Intel/oneAPI/ipp/latest/include")
    set(TBB_BIN "C:/Program Files (x86)/Intel/oneAPI/tbb/latest/redist/intel64/vc14")
    set(TBB_LIB_DIR "C:/Program Files (x86)/Intel/oneAPI/tbb/latest/lib/intel64/vc14")
    set(IPP_LIB_DIR "C:/Program Files (x86)/Intel/oneAPI/ipp/latest/lib/intel64")
    set(IPP_BIN_DIR "C:/Program Files (x86)/Intel/oneAPI/ipp/latest/redist/intel64;C:/Program Files (x86)/Intel/oneAPI/ipp/latest/redist/intel64/tl/tbb;C:/Users/RS/Downloads/opencv_4.5.5/build/x64/vc15/bin")
    set(IPP_TL_TBB_DIR "C:/Program Files (x86)/Intel/oneAPI/ipp/latest/lib/intel64/tl/tbb")
    set(SYCL_PATH "C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/ocloc;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/bin/intel64;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/redist/intel64_win/compiler;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/oclfpga/host/windows64/bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/oclfpga/llvm/aocl-bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/oclfpga/windows64/bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/oclfpga/bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/../../../tbb/latest/redist/intel64/vc_mt;")
else()
    set(OpenCV_DIR "/opt/intel/openvino_2021/opencv")
    set(IPP_LIB_DIR "/opt/intel/oneapi/ipp/latest/lib/intel64")
    set(TBB_LIB_DIR "/opt/intel/oneapi/tbb/latest/lib/intel64/gcc4.8")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -qtbb")
    set(CMAKE_CXX_COMPILER "icpx")
    set(CMAKE_CXX_STANDARD 17)
    # set(CMAKE_CXX_FLAGS "-O2 -fsycl -std=c++17 -D_GLIBCXX_USE_TBB_PAR_BACKEND=0")
    set(CMAKE_CXX_FLAGS "-O2 -fsycl -fopenmp -std=c++17 ")
endif()
if(WIN32)
find_library(TBB tbb12 PATHS ${TBB_LIB_DIR})
endif()

find_library(IPP_S ipps PATHS ${IPP_LIB_DIR})
find_library(IPP_CV ippcv PATHS ${IPP_LIB_DIR})
find_library(IPP_I ippi PATHS ${IPP_LIB_DIR})
find_library(IPP_CORE ippcore PATHS ${IPP_LIB_DIR})
find_library(IPP_I_TL_TBB ippi_tl_tbb PATHS ${IPP_TL_TBB_DIR})



find_package(OpenCV REQUIRED)

##下面是输出信息
message(STATUS "Opnecv ;ibrary status: ")
message(STATUS "> version: ${OpenCV_VERSION} ")
message(STATUS "libraries: ${OpenCV_LIBS} ")
message(STATUS "> include: ${OpenCV_INCLUDE_DIRS}  ")


include_directories(${OpenCV_INCLUDE_DIRS} ${IPP_INCLUDE_DIR}) 


add_executable(Resize Resize.cpp Resize.h)

if(WIN32)
    target_link_libraries( Resize ${OpenCV_LIBS}  ${IPP_CV} ${IPP_I} ${IPP_CORE} ${IPP_S} ${TBB} ${IPP_I_TL_TBB} libomp )
else()
    target_link_libraries( Resize ${OpenCV_LIBS}  ${IPP_CV} ${IPP_I} ${IPP_CORE} ${IPP_S} ${IPP_I_TL_TBB}  )
endif()

#if(WIN32)
#set_target_properties(Resize PROPERTIES VS_DEBUGGER_ENVIRONMENT  "PATH=${TBB_BIN};${IPP_BIN_DIR};${SYCL_PATH};")
#Sendif()
