cmake_minimum_required(VERSION 3.15)


if(WIN32)
    set(CMAKE_GENERATOR_TOOLSET "Intel(R) oneAPI DPC++ Compiler 2023")
    set(OpenCV_DIR "C:/Users/RS/Downloads/opencv_4.5.5/build")
    set(IPP_DIR "C:/Program Files (x86)/Intel/oneAPI/ipp/latest/lib/intel64") 
    
    set(IPP_BIN_DIR "C:/Program Files (x86)/Intel/oneAPI/ipp/latest/redist/intel64;C:/Program Files (x86)/Intel/oneAPI/ipp/latest/redist/intel64/tl/tbb;C:/Users/RS/Downloads/opencv_4.5.5/build/x64/vc15/bin")
    set(SYCL_PATH "C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/ocloc;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/bin/intel64;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/redist/intel64_win/compiler;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/oclfpga/host/windows64/bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/oclfpga/llvm/aocl-bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/oclfpga/windows64/bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/lib/oclfpga/bin;C:/Program Files (x86)/Intel/oneAPI/compiler/2023.0.0/windows/../../../tbb/latest/redist/intel64/vc_mt;")

else()
    set(CMAKE_CXX_COMPILER "icpx")
    set(IPP_DIR "/opt/intel/oneapi/ipp/latest/lib/intel64") 
    include_directories("/opt/intel/oneapi/ipp/latest/include/ipp") 
endif()


project(accumulateSquare LANGUAGES CXX)
set(CMAKE_BUILD_TYPE Release)
if(WIN32)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Qopenmp")
else()
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp -O3 -mavx2")
endif()


find_package(OpenCV REQUIRED)
find_library(IPP_CORE ippcore PATHS ${IPP_DIR})
find_library(IPP_I ippi PATHS ${IPP_DIR})
find_library(IPP_S ipps PATHS ${IPP_DIR})
find_library(IPP_CV ippcv PATHS ${IPP_DIR})
find_library(IPP_VM ippvm PATHS ${IPP_DIR})

include_directories(${OpenCV_INCLUDE_DIRS} )
add_executable (accumulateSquare main.cpp)

if(WIN32)
    target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS} ${IPP_CORE} ${IPP_S} ${IPP_I} ${IPP_VM} ${IPP_CV} libomp )
else()
    target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS} ${IPP_CORE} ${IPP_S} ${IPP_I} ${IPP_VM} ${IPP_CV})
endif()


add_custom_target (run ./accumulateSquare)


if(WIN32)
set_target_properties( accumulateSquare PROPERTIES VS_DEBUGGER_ENVIRONMENT  "PATH=${OpenCV_DIR}/bin;${TBB_BIN};${IPP_BIN_DIR};${SYCL_PATH};")
# set_target_properties(  accumulateSquare PROPERTIES VS_DEBUGGER_COMMAND_ARGUMENTS "${CMAKE_CURRENT_SOURCE_DIR}/data/color_4288.jpg" )
endif()